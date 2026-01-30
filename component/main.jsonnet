// main template for managed-manifests
local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.managed_manifests;

// Define outputs below
{
  [k]: params[k]
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
