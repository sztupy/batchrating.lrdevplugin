local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'
local LrApplication = import 'LrApplication'

local function showCustomDialog()

  LrFunctionContext.callWithContext( "showCustomDialog", function( context )

      local f = LrView.osFactory()

      local filenames_field = f:edit_field {
        title = "filenames",
        height_in_lines = 10,
        width_in_chars = 40,
        value = '',
      }

      local rating_field = f:edit_field {
        title = "rating",
        height_in_lines = 1,
        width_in_chars = 40,
        value = 'red',
      }

      local logs_field = f:edit_field {
        title = "logs",
        height_in_lines = 10,
        width_in_chars = 40,
        value = ''
      }

      local c = f:column {
        filenames_field,
        rating_field,
        f:push_button {
          title = "Update",
          action = function()
            import "LrTasks".startAsyncTask( function()
              logs_field.value = "Starting search\n"

              local catalog = import "LrApplication".activeCatalog()
              catalog:withWriteAccessDo("Batch set rating", function( context )
                for i,photo in ipairs(catalog:getMultipleSelectedOrAllPhotos()) do
                  for fname in string.gmatch(filenames_field.value, "%w+") do
                    if string.find(photo:getFormattedMetadata('fileName'), fname) then
                      logs_field.value = logs_field.value .. "Found filename: " .. fname .. "\n"
                      photo:setRawMetadata('label', rating_field.value)
											photo:setRawMetadata('colorNameForLabel', rating_field.value)
                    end
                  end
                end
              end)
              logs_field.value = logs_field.value .. "Done...\n"
            end)
          end
        },
        logs_field
      }

      LrDialogs.presentModalDialog {
          title = "Batch Rating",
          contents = c
      }

  end)
end

showCustomDialog()
