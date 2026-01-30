// main template for managed-manifests
local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.managed_manifests;

// Define outputs below
{
  [local base =
      if std.endsWith(k, '.yaml') then
        std.substr(k, 0, std.length(k) - 5)
      else if std.endsWith(k, '.yml') then
        std.substr(k, 0, std.length(k) - 4)
      else
        k;
    base
  ]: params[k]
  for k in (
    if params == null then
      []
    else
      std.filter(
        function(k) k != 'namespace' && !std.startsWith(k, '='),
        std.objectFields(params)
      )
  )
}
