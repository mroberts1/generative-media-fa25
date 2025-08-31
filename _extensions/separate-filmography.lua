-- separate-filmography.lua
-- Filter to separate @video entries into filmography section

function Div(div)
  if div.identifier == "refs" then
    -- This will contain only non-video references
    div.classes:insert("bibliography-only")
    return div
  elseif div.identifier == "filmrefs" then
    -- This will contain only video references  
    div.classes:insert("filmography-only")
    return div
  end
end

-- Post-process to move video entries to filmography
function Meta(meta)
  if meta.nocite then
    -- This ensures all references are processed
    return meta
  end
end
