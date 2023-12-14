import random
import string

def random_change(str_):
    op = random.randint(0, 2)
    pos = random.randint(0, len(str_) - 1)
    char = chr(random.randint(33, 126))

    if op == 0:
        return str_[:pos] + char + str_[pos:]
    elif op == 1:
        if len(str_) > 1:
            return str_[:pos] + str_[pos + 1:]
        else:
            return str_
    else:
        return str_[:pos] + char + str_[pos + 1:]

def test_quine(code):
    try:
        exec(code)
        return True
    except Exception:
        return False

intron = "// this is an intron"

original_code = r"""
def random_change(str_):
    op = random.randint(0, 2)
    pos = random.randint(0, len(str_) - 1)
    char = chr(random.randint(33, 126))
    if op == 0:
        return str_[:pos] + char + str_[pos:]
    elif op == 1:
        if len(str_) > 1:
            return str_[:pos] + str_[pos + 1:]
        else:
            return str_
    else:
        return str_[:pos] + char + str_[pos + 1:]

def test_quine(code):
    try:
        exec(code)
        return True
    except Exception:
        return False

intron = "// this is an intron"
original_code = # (This will be replaced by the actual code representation)

def quine(code):
    while True:
        mutated_code = random_change(code)
        intron_index = mutated_code.find(intron)
        if intron_index != -1:
            mutated_code = mutated_code[:intron_index]
        mutated_code += intron

        if test_quine(mutated_code):
            print(mutated_code)
            code = mutated_code

quine(original_code)
"""

# Replace the placeholder with the actual code representation
original_code = original_code.replace('original_code = # (This will be replaced by the actual code representation)', 'original_code = r"""' + original_code + '"""')

def quine(code):
    while True:
        mutated_code = random_change(code)
        intron_index = mutated_code.find(intron)
        if intron_index != -1:
            mutated_code = mutated_code[:intron_index]
        mutated_code += intron

        if test_quine(mutated_code):
            print(mutated_code)
            code = mutated_code

quine(original_code)
