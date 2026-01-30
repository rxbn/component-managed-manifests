// main template for managed-manifests
local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.managed_manifests;

local keys =
  if params == null then
    []
  else
    std.filter(
      function(k) k != 'namespace' && !std.startsWith(k, '='),
      std.objectFields(params)
    );

local normalize(k) =
  if std.length(k) >= 5 && std.substr(k, std.length(k) - 5, 5) == '.yaml' then
    std.substr(k, 0, std.length(k) - 5)
  else if std.length(k) >= 4 && std.substr(k, std.length(k) - 4, 4) == '.yml' then
    std.substr(k, 0, std.length(k) - 4)
  else
    k;

// Define outputs below
{
  [normalize(k)]: params[k]
  for k in keys
}
