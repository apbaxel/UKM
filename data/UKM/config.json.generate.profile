cat << CTAG
{
    name:PROFILE,
    elements:[
		{ STitleBar:{
			title:"Configuration Profiles"
		}},
			{ SOptionList:{
				title:"Selected Profile",
				description:"Choose the settings you want and apply your choice in Synapse before using the action buttons below.",
				action:"restorebackup pickconfig",
				default:"None",
				values:[ "None",
					`for BAK in \`$UKM/actions/restorebackup listconfig\`; do
						echo "\"$BAK\","
					done`
				],
				notify:[
					{
						on:APPLY,
						do:[ REFRESH, APPLY ],
						to:"generic $UKM/files/bck_prof"
					}
				]
			}},
		{ STitleBar:{
			title:"Profile Actions",
		}},
			{ SDescription:{
				description:"NOTE: After you restore a profile, you have to press the X button on top to load the settings."
			}},
			{ SButton:{
				label:"Restore Selected Profile",
				action:"restorebackup applyconfig",
				notify:[
					{
						on:APPLY,
						do:[ REFRESH, APPLY ],
						to:"restorebackup pickconfig"
					}
				]
			}},
			{ SButton:{
				label:"Delete Selected Profile",
				action:"restorebackup delconfig",
				notify:[
					{
						on:APPLY,
						do:[ REFRESH, APPLY ],
						to:"restorebackup pickconfig"
					}
				]
			}},
		{ SPane:{
			title:"Backup Actions"
		}},
			{ SGeneric:{
				title:"Profile Name",
				default:"None",
				action:"generic $UKM/files/bck_prof",
			}},
			{ SDescription:{
				description:"First set a name above and apply. After this you can press the Backup Current Profile button below."
			}},
			{ SButton:{
				label:"Backup Current Profile",
				action:"restorebackup keepconfig",
				notify:[
					{
						on:APPLY,
						do:[ REFRESH, APPLY ],
						to:"generic $UKM/files/bck_prof"
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
