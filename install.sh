#!/bin/bash

rm /usr/bin/volumancer
rm /usr/bin/volumancerd
rm /Library/LaunchAgents/not.an.imposter.volumancerd.plist


curl https://raw.githubusercontent.com/notanimposter/volumancer/master/volumancer > /usr/bin/volumancer

chmod +x /usr/bin/volumancer
curl https://raw.githubusercontent.com/notanimposter/volumancer/master/volumancerd > /usr/bin/volumancerd

chmod +x /usr/bin/volumancerd

touch /Library/LaunchAgents/not.an.imposter.volumancerd.plist

read -d '' String <<"EOF"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>Label</key>
		<string>not.an.imposter.volumancerd</string>

		<key>ProgramArguments</key>
		<array>
			<string>/usr/bin/volumancerd</string>
		</array>

		<key>RunAtLoad</key>
		<true/>
	</dict>
</plist>
EOF
echo "${String}" | tee /Library/LaunchAgents/not.an.imposter.volumancerd.plist

chown root /Library/LaunchAgents/not.an.imposter.volumancerd.plist

sleep 5

launchctl load /Library/LaunchAgents/not.an.imposter.volumancerd.plist

launchctl start not.an.imposter.volumancerd
