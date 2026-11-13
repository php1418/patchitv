package app.patchitv

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompat

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        // Mostrar mensaje de bienvenida en turco
        Toast.makeText(this, "YouTube TV Patcher - Hoş geldiniz", Toast.LENGTH_LONG).show()
    }
    
    /**
     * Abre el selector de archivos para elegir un APK de YouTube Android TV
     */
    fun selectApk() {
        val intent = Intent(Intent.ACTION_GET_CONTENT).apply {
            type = "application/vnd.android.package-archive"
            putExtra(Intent.EXTRA_TITLE, "YouTube TV APK seçin")
        }
        startActivityForResult(intent, 1)
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 1 && resultCode == Activity.RESULT_OK && data != null) {
            val uri: Uri = data.data
            processApk(uri)
        }
    }
    
    /**
     * Procesa el APK seleccionado y aplica los parches
     * - Agrega soporte de idioma turco
     * - Mantiene interfaz original de YouTube TV
     * - Configura para Android TV
     */
    private fun processApk(apkUri: Uri) {
        val patchManager = PatchManager()
        val result = patchManager.patchApk(this, apkUri)
        
        when (result) {
            is Uri -> {
                Toast.makeText(this, "YouTube TV parcheado exitosamente!", Toast.LENGTH_LONG).show()
                // Aquí podrías intentarlo instalar o compartir el resultado
            }
            else -> {
                Toast.makeText(this, "Parcheo falló, intente novamente", Toast.LENGTH_LONG).show()
            }
        }
    }
}