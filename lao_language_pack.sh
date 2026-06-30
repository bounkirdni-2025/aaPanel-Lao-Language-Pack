#!/bin/bash

# ບ່ອນເກັບໄຟລ໌ຂອງສາດສະດາ Bone NI
REPO_URL="https://github.com/bounkirdni-2025/aaPanel-Lao-Language-Pack"
LANGUAGE_PACK="BTPanel"

# ເສັ້ນທາງຕິດຕັ້ງໃນ Server
INSTALL_DIR="/www/server/panel/$LANGUAGE_PACK"

# ກວດສອບສິດການຂຽນໄຟລ໌
if [ ! -w "/www/server/panel/" ]; then
    echo "ຂໍ້ຜິດພາດ: ທ່ານບໍ່ມີສິດຂຽນລົງໃນໂຟນເດີ /www/server/panel/. ກະລຸນາໃຊ້ sudo ເພື່ອລັນ script ນີ້."
    exit 1
fi

# ເລີ່ມດາວໂຫລດ
echo "ກຳລັງດາວໂຫລດຊຸດພາສາລາວ aaPanel-Lao-Language-Pack ໂດຍ Bone NI..."
if command -v git &> /dev/null; then
    git clone --depth=1 "$REPO_URL" temp_repo
else
    wget -q -O temp_repo.zip "$REPO_URL/archive/refs/heads/main.zip"
    unzip -q temp_repo.zip
    mv aaPanel-Lao-Language-Pack-main temp_repo
    rm -rf temp_repo.zip
fi

# ກັອບປີ້ໄຟລ໌ລົງລະບົບ (ຍົກເວັ້ນໄຟລ໌ທີ່ບໍ່ຈຳເປັນ)
shopt -s extglob
cp -r temp_repo/!(LICENSE|README.md|lao_language_pack.sh)/* "$INSTALL_DIR/" || {
    echo "ຂໍ້ຜິດພາດ: ບໍ່ສາມາດກັອບປີ້ໄຟລ໌ລົງໃນ $INSTALL_DIR ໄດ້."
    exit 1
}

# ລຶບໄຟລ໌ຊົ່ວຄາວ
rm -rf temp_repo

# ແຈ້ງເຕືອນເມື່ອສຳເລັດ
echo -e "\nຊຸດພາສາລາວ 'Lao Language' ຕິດຕັ້ງສຳເລັດແລ້ວ!\n"
echo "ວິທີການປ່ຽນພາສາ:"
echo "1. ເຂົ້າໄປທີ່ໜ້າຫຼັກຂອງ aaPanel."
echo "2. ຢູ່ມຸມຂວາເທິງ, ຄລິກບ່ອນປ່ຽນພາສາແລ້ວເລືອກ 'Lao'."
echo "3. ຖ້າບໍ່ເຫັນ, ໃຫ້ໄປທີ່ 'Settings' -> 'Language' ແລ້ວເລືອກ 'Lao'."
echo "4. ຢ່າລືມ Refresh ໜ້າຈໍອີກບາດໜຶ່ງເດີ້!"
