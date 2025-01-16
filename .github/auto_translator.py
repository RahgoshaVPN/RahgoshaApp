# Auto translator from https://github.com/hiddify/hiddify-app/blob/main/.github/auto_translator.py

import json
from deep_translator import GoogleTranslator
import sys
import os


root_dir = os.path.dirname(os.path.abspath(__file__))

def get_path(lang):
    base_dir = os.path.abspath(f'{root_dir}/../assets/translations')
    lang_file = f'{lang}.json'
    path = os.path.join(base_dir, lang_file)
    if path.startswith(base_dir):
        return path
    else:
        raise ValueError('Invalid language file path')


def read_translate(lang):
    pat = get_path(lang)
    if not os.path.isfile(pat):
        return {}
    with open(pat) as f:
        return json.load(f)


def recursive_translate(src, dst, translator):
    for sk, sv in src.items():
        if type(sv) == str:
            if sk not in dst or not dst[sk]:
                dst[sk] = translator.translate(sv)
                print(sk, sv, dst[sk])
            if not dst[sk]:
                del dst[sk]
        else:
            if sk not in dst:
                dst[sk] = {}
            recursive_translate(sv, dst[sk], translator)


if __name__ == "__main__":
    src = sys.argv[1]
    dst = sys.argv[2]

    src_pofile = read_translate(src)
    dst_pofile = read_translate(dst)

    just_lang = lambda t: t.split("-")[0]

    translator = GoogleTranslator(source=just_lang(src), target=just_lang(dst) if dst != 'zh' else "zh-CN")
    recursive_translate(src_pofile, dst_pofile, translator)

    with open(os.path.abspath(get_path(dst)), 'w') as df:
        json.dump(dst_pofile, df, ensure_ascii=False, indent=4)