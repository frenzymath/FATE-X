"""Extract auxiliary declarations from this benchmark's Lean source layout.

This is intentionally a source-layout reader, not a general Lean parser. Commands
in FATEX/*.lean start in column zero; declaration bodies are indented. Comments
are masked with their positions preserved, including nested block comments.
Namespaces, imports, opens and section variables remain in formal_statement:
declaration is an ordered list of helper commands, not a standalone Lean file.
"""
import re


MODIFIERS = r"(?:(?:noncomputable|local|private|protected|scoped|unsafe)\s+)*"
COMMAND = re.compile(
    r"(?m)^" + MODIFIERS +
    r"(?P<kind>def|abbrev|instance|class|structure|inductive|opaque|theorem|lemma|example|import|namespace|"
    r"section|end|open|variable|attribute|set_option|universe|notation|infix|prefix|postfix)\b"
    r"|^@\["
)
HELPERS = {"def", "abbrev", "instance", "class", "structure", "inductive", "opaque"}


def mask_comments(source):
    chars = list(source)
    i = 0
    while i < len(source):
        if source[i] == '"':
            i += 1
            while i < len(source):
                if source[i] == "\\":
                    i += 2
                elif source[i] == '"':
                    i += 1
                    break
                else:
                    i += 1
        elif source.startswith("--", i):
            stop = source.find("\n", i)
            if stop == -1:
                stop = len(source)
            chars[i:stop] = " " * (stop - i)
            i = stop
        elif source.startswith("/-", i):
            start, depth = i, 1
            i += 2
            while i < len(source) and depth:
                if source.startswith("/-", i):
                    depth += 1
                    i += 2
                elif source.startswith("-/", i):
                    depth -= 1
                    i += 2
                else:
                    i += 1
            if depth:
                raise ValueError("Unterminated Lean block comment")
            for j in range(start, i):
                if chars[j] != "\n":
                    chars[j] = " "
        else:
            i += 1
    return "".join(chars)


def helper_spans(source):
    masked = mask_comments(source)
    commands = list(COMMAND.finditer(masked))
    spans = []
    attributes_start = None
    for index, command in enumerate(commands):
        start = command.start()
        stop = commands[index + 1].start() if index + 1 < len(commands) else len(source)
        code_end = start + len(masked[start:stop].rstrip())
        if command.group("kind") is None:
            if attributes_start is None:
                attributes_start = start
            continue
        if command.group("kind") in HELPERS:
            spans.append((attributes_start if attributes_start is not None else start, code_end))
        attributes_start = None
    return spans


def declarations(source):
    return [source[start:stop].strip() for start, stop in helper_spans(source)]


def informal_statement(source):
    """Use the docstring immediately preceding the task theorem."""
    masked = mask_comments(source)
    tasks = [m for m in COMMAND.finditer(masked) if m.group("kind") == "theorem"]
    if len(tasks) != 1:
        raise ValueError("Expected exactly one benchmark theorem")
    docstrings = list(re.finditer(r"/--(.*?)-/", source[:tasks[0].start()], re.S))
    if not docstrings:
        raise ValueError("Missing benchmark theorem docstring")
    return docstrings[-1].group(1).strip()


def check_entry(entry, source):
    number = entry["id"]
    assert entry["formal_statement"].rstrip() == source.rstrip(), f"formal_statement mismatch: {number}"
    assert entry["declaration"] == declarations(source), f"declaration mismatch: {number}"
    assert entry["informal_statement"] == informal_statement(source), f"informal_statement mismatch: {number}"
    assert len(re.findall(r"\bsorry\b", mask_comments(source))) == 1, f"Proof hole count: {number}"
