#!/bin/bash

# YouTube TV APK Patch Script
# Bu script YouTube TV APK'ını Türkçe ve YouTube TV için hazırlar

set -e

echo "🔧 YouTube TV APK Patch Aracı"
echo "=============================="

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

APK_URL="https://github.com/jair1c/farotv-patches/releases/download/v1.0.0/app.tvpatches.android.youtube.tv.apk"
OUTPUT_DIR="$HOME/patched-apks"
MICROG_URL="https://github.com/inotia00/mMicroG/releases/download/v0.3.2.4.240913-14/mMicroG-0.3.2.4.240913-14.apk"

echo ""
echo "📥 Adım 1: YouTube TV APK indiriliyor..."

# Çıktı klasörü oluştur
mkdir -p "$OUTPUT_DIR"

# Eğer kullanıcı APK sağlamışsa onu kullan, yoksa indir
if [ -n "$1" ] && [ -f "$1" ]; then
    INPUT_APK="$1"
    echo "✅ Kullanıcı APK'sı kullanılıyor: $INPUT_APK"
else
    echo "⚠️ Kendi YouTube TV APK'nızı sağlayın veya aşağıdaki adımları izleyin:"
    echo ""
    echo "1. APK Mirror'dan YouTube TV APK indirin:"
    echo "   https://www.apkmirror.com/apk/google-inc/youtube/youtube-for-android-tv/"
    echo ""
    echo "2. İndirdiğiniz APK'yı bu script'e parametre olarak verin:"
    echo "   ./patch-youtube-tv.sh /path/to/youtube-tv.apk"
    echo ""
    echo "📦 Alternatif: MicroG-RE indirin ve kurun:"
    echo "   $MICROG_URL"
    exit 0
fi

echo ""
echo "🔍 APK bilgileri kontrol ediliyor..."

# APK tool kontrolü
if ! command -v apktool &> /dev/null; then
    echo -e "${YELLOW}⚠️  apktool bulunamadı. Kurulum gerekli:${NC}"
    echo "   sudo apt install apktool"
    echo "   veya"
    echo "   brew install apktool"
    exit 1
fi

# APK'yı decompile et
APK_NAME=$(basename "$INPUT_APK" .apk)
WORK_DIR="$OUTPUT_DIR/$APK_NAME-work"

echo ""
echo "🔓 APK decompile ediliyor..."
apktool d "$INPUT_APK" -o "$WORK_DIR" --no-src --no-res

# Manifest dosyasını düzenle
MANIFEST="$WORK_DIR/AndroidManifest.xml"

echo ""
echo "📝 Manifest düzenleniyor (Türkçe locale ekleniyor)..."

# Türkçe locale ekle
if grep -q "android:localeConfig" "$MANIFEST"; then
    echo "✅ Locale config zaten var"
else
    # Locale config ekle
    sed -i 's|<application|<application\n        android:localeConfig="@xml/locales_config"|' "$MANIFEST"
fi

# TV özellikleri ekle
if ! grep -q "leanback" "$MANIFEST"; then
    sed -i 's|</application>|    <uses-feature android:name="android.software.leanback" android:required="false"/>\n    <uses-feature android:name="android.hardware.touchscreen" android:required="false"/>\n</application>|' "$MANIFEST"
fi

# Locale config XML oluştur
LOCALES_DIR="$WORK_DIR/res/xml"
mkdir -p "$LOCALES_DIR"

cat > "$LOCALES_DIR/locales_config.xml" << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<locale-config xmlns:android="http://schemas.android.com/apk/res/android">
    <locale android:name="tr"/>
    <locale android:name="en"/>
</locale-config>
EOF

echo "✅ Türkçe locale config oluşturuldu"

# Strings dosyasını düzenle (Türkçe ekle)
STRINGS_TR="$WORK_DIR/res/values-tr/strings.xml"
mkdir -p "$(dirname "$STRINGS_TR")"

cat > "$STRINGS_TR" << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">YouTube TV</string>
    <string name="search_hint">Ara</string>
    <string name="settings">Ayarlar</string>
    <string name="sign_in">Oturum aç</string>
    <string name="home">Ana sayfa</string>
    <string name="subscriptions">Abonelikler</string>
    <string name="library">Kitaplık</string>
    <string name="history">Geçmiş</string>
    <string name="your_videos">Videolarınız</string>
    <string name="watch_later">Daha sonra izle</string>
    <string name="liked_videos">Beğenilen videolar</string>
    <string name="downloads">İndirmeler</string>
    <string name="quality">Kalite</string>
    <string name="notifications">Bildirimler</string>
    <string name="privacy_policy">Gizlilik politikası</string>
    <string name="terms_of_service">Hizmet koşulları</string>
    <string name="version">Sürüm</string>
    <string name="update_available">Güncelleme mevcut</string>
    <string name="downloading">İndiriliyor…</string>
    <string name="installing">Kuruluyor…</string>
    <string name="install">Kur</string>
    <string name="cancel">İptal</string>
    <string name="ok">Tamam</string>
    <string name="yes">Evet</string>
    <string name="no">Hayır</string>
    <string name="loading">Yükleniyor…</string>
    <string name="error">Hata</string>
    <string name="retry">Tekrar dene</string>
    <string name="no_connection">İnternet bağlantısı yok</string>
    <string name="video_unavailable">Video kullanılamıyor</string>
    <string name="autoplay">Otomatik oynatma</string>
    <string name="captions">Altyazılar</string>
    <string name="playback_speed">Oynatma hızı</string>
    <string name="skip_intro">İntroyu atla</string>
    <string name="next_video">Sonraki video</string>
    <string name="related_videos">İlgili videolar</string>
    <string name="comments">Yorumlar</string>
    <string name="share">Paylaş</string>
    <string name="save_to_playlist">Oynatma listesine kaydet</string>
    <string name="remove_from_watch_later">Daha sonra izleden kaldır</string>
    <string name="add_to_watch_later">Daha sonra izle\'ye ekle</string>
    <string name="not_interested">İlgilenmiyorum</string>
    <string name="don_t_recommend_channel">Bu kanalı önerme</string>
    <string name="report">Bildir</string>
    <string name="about">Hakkında</string>
    <string name="help">Yardım</string>
    <string name="send_feedback">Geri bildirim gönder</string>
    <string name="clear_watch_history">İzleme geçmişini temizle</string>
    <string name="clear_search_history">Arama geçmişini temizle</string>
    <string name="pause_watch_history">İzleme geçmişini duraklat</string>
    <string name="manage_all_history">Tüm geçmişi yönet</string>
    <string name="connected_accounts">Bağlı hesaplar</string>
    <string name="try_youtube_premium">YouTube Premium\'u deneyin</string>
    <string name="no_ads">Reklamsız izleyin</string>
    <string name="background_play">Arka planda oynatma</string>
    <string name="downloads_premium">İndirmeler</string>
    <string name="youtube_music">YouTube Music</string>
</resources>
EOF

echo "✅ Türkçe strings dosyası oluşturuldu"

# Recompile
echo ""
echo "🔨 APK yeniden compile ediliyor..."
apktool b "$WORK_DIR" -o "$OUTPUT_DIR/${APK_NAME}-patched.apk"

# Temizlik
echo ""
echo "🧹 Geçici dosyalar temizleniyor..."
rm -rf "$WORK_DIR"

echo ""
echo -e "${GREEN}✅ Başarılı!${NC}"
echo ""
echo "📦 Patchlenmiş APK: $OUTPUT_DIR/${APK_NAME}-patched.apk"
echo ""
echo "📱 Kurulum adımları:"
echo "   1. APK'yı Android TV cihazınıza veya telefonunuza aktarın"
echo "   2. Ayarlar → Güvenlik → Bilinmeyen kaynaklar'ı etkinleştirin"
echo "   3. APK'yı kurun"
echo ""
echo "🔑 MicroG-RE gerekli (oturum açmak için):"
echo "   $MICROG_URL"
echo ""
echo "🎉 Keyifli izlemeler!"