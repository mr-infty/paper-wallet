GEN_QR_CODE = python src/gen-qrcode.py
PUBLIC_KEY_DIR = public-keys/
WALLET_DIR = wallets/
SRC_DIR = src/

PUBLIC_KEYS = $(wildcard $(addsuffix *.asc, $(PUBLIC_KEY_DIR)))
OBJ = $(patsubst $(PUBLIC_KEY_DIR)%.asc, $(WALLET_DIR)%.ps, $(PUBLIC_KEYS))

.PHONY: all clean

all: $(OBJ)

clean:
	rm -f $(OBJ)

$(WALLET_DIR)%.svg: $(PUBLIC_KEY_DIR)%.asc
	$(GEN_QR_CODE) $< $@

$(WALLET_DIR)%.eps: $(WALLET_DIR)%.svg
	inkscape $< -E $@ --export-ignore-filters --export-ps-level=3

$(WALLET_DIR)%.ps: $(WALLET_DIR)%.eps
	cp -f $< $(SRC_DIR)_qr-code.eps
	cp -f $(patsubst $(WALLET_DIR)%.eps, $(PUBLIC_KEY_DIR)%.asc, $<) $(SRC_DIR)_pkey.txt

	gs -dNOPAUSE -dBATCH -sOutputFile=$@ -sDEVICE=ps2write $(SRC_DIR)paper-wallet.ps

	rm -f $(SRC_DIR)_pkey.txt
	rm -f $(SRC_DIR)_qr-code.eps

