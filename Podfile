platform :ios, '17.6'

target 'MyFinance' do
  use_frameworks!

  pod 'FirebaseAuth'
  pod 'FirebaseFirestore' # Adicione o Firestore aqui

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    
    # --- CORREÇÃO PARA O ERRO -G NO BORINGSSL ---
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          # Remove a flag que causa o erro de interpretação no compilador
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
    # --------------------------------------------

    target.build_configurations.each do |config|
      config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
      
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end