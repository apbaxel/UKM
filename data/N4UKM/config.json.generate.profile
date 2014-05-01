cat << CTAG
{
    name:PROFILE,
    elements:[
		{ STitleBar:{
			title:"Configuration Profiles"
		}},
			{ SOptionList:{
				title:"Selected Profile",
				description:"Choose the settings backup you want and apply your choice in Synapse before using the action buttons below.",
				action:"restorebackup pickconfig",
				default:"None",
				values:[ "None",
					`for BAK in \`/data/N4UKM/actions/restorebackup listconfig\`; do
						echo "\"$BAK\","
					done`
				]
			}},
		{ STitleBar:{
			title:"Settings Actions",
		}},
			{ SButton:{
				label:"Restore Selected Profile",
				action:"restorebackup applyconfig"
			}},
			{ SButton:{
				label:"Delete Selected Profile",
				action:"restorebackup delconfig",
				notify:[
						{
							on:APPLY,
							do:[ RESET, REFRESH ],
							to:"restorebackup pickconfig"
						}
				]
			}},
			{ SButton:{
				label:"Backup Current Profile",
				action:"restorebackup keepconfig",
				notify:[
						{
							on:APPLY,
							do:REFRESH,
							to:"restorebackup pickconfig"
						}
				]
			}},
			{ SPane:{
				title:"General Actions",
				description:"To update/refresh lists, select Restart Synapse below."
			}},
			{ SButton:{
				label:"Restart Synapse",
				action:"restorebackup restart"
			}},
    ]
}
CTAG
