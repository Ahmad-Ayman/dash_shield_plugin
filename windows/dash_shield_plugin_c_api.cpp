#include "include/dash_shield/dash_shield_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dash_shield_plugin.h"

void DashShieldPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dash_shield::DashShieldPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
