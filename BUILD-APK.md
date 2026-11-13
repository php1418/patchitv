# 📱 PatchItV - APK Oluşturma Kılavuzu

## 🎯 3 Farklı Yöntem

### Yöntem 1: GitHub Actions ile Otomatik (ÖNERİLEN) ⭐

Bu yöntem en kolayıdır. GitHub'a yükleyin, otomatik APK oluşsun.

#### Adımlar:

1. **GitHub'da yeni repo oluşturun**
   ```
   https://github.com/new
   Repo adı: patchitv
   ```

2. **Projeyi GitHub'a yükleyin**
   ```bash
   cd /workspace/patchitv
   git init
   git add .
   git commit -m "Initial commit - YouTube TV patcher"
   git branch -M main
   git remote add origin https://github.com/KULLANICI_ADINIZ/patchitv.git
   git push -u origin main
   ```

3. **GitHub Actions otomatik çalışacak**
   - `Actions` sekmesine gidin
   - "Build Android APK" workflow'u çalışacak
   - Yeşil tik yanına tıklayın
   - `patchitv-debug-apk` artifact'ini indirin

4. **APK'yı telefonunuza kurun**
   - İndirdiğiniz `app-debug.apk` dosyasını telefonunuza gönderin
   - Kurun ve çalıştırın

---

### Yöntem 2: Android Studio ile Manuel

#### Adımlar:

1. **Android Studio'yu açın**
   - File → Open → `/workspace/patchitv`

2. **Gradle Sync bekleyin**
   - Alt sağ köşede progress bar bitecek

3. **APK'yı oluşturun**
   - Build → Build APK(s)
   - Veya: `./gradlew assembleDebug`

4. **APK konumu**
   ```
   /workspace/patchitv/app/build/outputs/apk/debug/app-debug.apk
   ```

5. **Telefona kurun**
   - APK'yı telefonunuza aktarın
   - Kurun

---

### Yöntem 3: Bash Script ile (Linux/Mac)

#### Gereksinimler:
```bash
# Ubuntu/Debian
sudo apt install apktool zipalign apksigner

# Mac
brew install apktool
```

#### Adımlar:

1. **YouTube TV APK indirin**
   ```
   https://www.apkmirror.com/apk/google-inc/youtube/youtube-for-android-tv/
   ```

2. **Script'i çalıştırın**
   ```bash
   cd /workspace/patchitv
   ./patch-youtube-tv.sh /path/to/youtube-tv.apk
   ```

3. **Patchlenmiş APK**
   ```
   ~/patched-apks/youtube-tv-patched.apk
   ```

---

## 📋 Gerekli Dosyalar

Projenizde zaten mevcut:

```
patchitv/
├── .github/workflows/build-apk.yml    ✅ GitHub Actions
├── app/
│   ├── build.gradle.kts               ✅ Build config
│   └── src/main/
│       ├── AndroidManifest.xml        ✅ Manifest (tr-TR)
│       ├── java/app/patchitv/
│       │   ├── MainActivity.kt        ✅ Ana aktivite
│       │   └── PatchManager.kt        ✅ Patch mantığı
│       └── res/
│           ├── values/strings.xml     ✅ Türkçe strings
│           ├── values/colors.xml      ✅ YouTube kırmızı
│           ├── values/styles.xml      ✅ Tema
│           └── layout/activity_main.xml ✅ UI
├── gradlew                            ✅ Gradle wrapper
├── gradle/wrapper/gradle-wrapper.properties ✅
├── patch-youtube-tv.sh                ✅ Bash script
├── build.gradle.kts                   ✅ Root build
└── settings.gradle.kts                ✅ Settings
```

---

## 🔑 MicroG-RE Kurulumu (Oturum Açmak İçin)

YouTube TV'de oturum açmak için MicroG-RE gerekli:

1. **MicroG-RE indirin**
   ```
   https://github.com/inotia00/mMicroG/releases
   ```

2. **Telefonunuza kurun**
   - Önce MicroG-RE
   - Sonra YouTube TV

3. **Oturum açın**
   - YouTube TV'yi açın
   - MicroG ile oturum açın

---

## 🎨 Özellikler

- ✅ Tamamen Türkçe arayüz
- ✅ YouTube orijinal kırmızı renk (#FF0000)
- ✅ Android TV uyumlu
- ✅ Leanback launcher desteği
- ✅ tr-TR locale config
- ✅ Türkçe strings dosyası

---

## ❓ Sorun Giderme

### "Gradle sync failed"
```bash
./gradlew clean
./gradlew build
```

### "SDK not found"
Android Studio'da:
- File → Project Structure → SDK Location
- Android SDK yolunu gösterin

### "Build failed"
```bash
./gradlew assembleDebug --stacktrace
```

---

## 📞 Yardım

Sorun yaşıyorsanız:
1. `./gradlew assembleDebug --info` çalıştırın
2. Hata mesajını GitHub Issues'a ekleyin

---

**🎉 Keyifli kullanımlar!**