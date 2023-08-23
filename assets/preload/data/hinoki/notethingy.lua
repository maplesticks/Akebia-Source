--custom opponent note skin <3 V2.2
--credit to vCherry.kAI.16 <3 if you remove this text then you're not allowed to use this

  --REPLACE THESE!!!
  local Strums_Texture = 'demonNOTE_assets'
  local Notes_Texture = 'demonNOTE_assets'
  
  function onUpdatePost()
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture);
      
      if not getPropertyFromGroup('notes', i, 'mustPress') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture);
      end
  
    end
  end
  