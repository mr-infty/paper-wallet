# Monero Paper Wallet Generator

Tool for generating PDF print templates of paper wallets for Monero.

## Prerequisites

You need to have the following installed:

* [`python`](https://www.python.org) (version >= 2.7)
* [`qrcode`](https://github.com/lincolnloop/python-qrcode) (python package)
* [`GNU Make`](https://www.gnu.org/software/make/)
* [`Ghostscript`](https://www.ghostscript.com)
* [`Inkscape`](https://inkscape.org) (for SVG->EPS conversion)

With the exception of `qrcode` and `Inkscape`, you'll probably have all of those installed
anyway (assuming you have a Unix-like OS). You can install it using Pythons own
package manager

    pip install qrcode[pil]

or using your systems package manager, e.g. 

    sudo apt install python-qrcode

on Debian/Ubuntu.

## Installation

    git clone https://github.com/mr-infty/paper-wallet.git
    cd paper-wallet

## Usage

*Step 1:* Put a text file containing your public Monero address, together with the prefix
`monero:`, into the directory `public-keys/`. This text file should have the
ending `.asc`.

*Step 2:* Run `make` and duplex-print (long edge) the generated PDF file in
`wallets/` on DIN A4 paper.

*Step 3:* Fill in the 25-word mnemonic seed in the indicated fields, making
sure that your writing stays completely within the border surrounding these
fields.

*Step 4:* Glue aluminium foil (or something else that is 100% opaque) onto the
indicated area, making sure you *completely cover it*.

*Step 5:* Fold four times, in the order indicated, then finally seal your
wallet using three hologram labels, in the places indicated.

## Known Issues

* Only Monero wallets are supported at the moment, more precisely, only wallets
  with mnemonic seed consistings of <= 25 words (and public key address of
  given length; see issue below). Of course it is trivial to modify this
  template to support any given wallet, but it is *not* trivial to support all
  possible wallets. Maybe I'll fix this some day.
* At the moment, the dimensions of the bounding box of the QR code being
  generated are *hardcoded* into the script (terrible, I know). In particular,
  it assumed that the `.asc` files contain 103 characters.
* The templates generated do not take into account that most printers cannot
  print completely till the edge of the paper. Most likely the template will
  therefore be downscaled during print. In this case, you may want to cut out
  the template along the outmost border.
