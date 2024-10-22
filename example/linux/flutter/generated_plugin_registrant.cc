//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dash_shield/dash_shield_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dash_shield_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DashShieldPlugin");
  dash_shield_plugin_register_with_registrar(dash_shield_registrar);
}
