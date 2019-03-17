import qrcode
import qrcode.image.svg
import sys
from collections import namedtuple

class BadArguments(Exception):
    pass

Arguments = namedtuple("Arguments", "input output")

def usage():
    return """usage: gen-qrcode <input-filename> <output-filename>
       gen qrcode <output-filename>"""

def parse_args(argv):
    if len(argv) != 2 and len(argv) != 3:
        raise BadArguments(usage())
    if len(argv) == 2:
        input_fname = ''
        output_fname = argv[1]
    else:
        input_fname = argv[1]
        output_fname = argv[2]
    return Arguments(input_fname, output_fname)

def main():
    try:
        args = parse_args(sys.argv)
    except BadArguments as e:
        print(e)
        exit(1)
    if args.input == '':
        text = sys.stdin.read()
    else:
        with open(args.input) as f:
            text = f.read()
    factory = qrcode.image.svg.SvgPathImage
    img = qrcode.make(text, image_factory=factory)
    img.save(args.output)

if __name__ == '__main__':
    main()
