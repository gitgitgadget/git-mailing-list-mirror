From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: git gui: Possible to see which commands are executed?
Date: Sun, 18 May 2008 14:03:35 +0200
Message-ID: <48301B17.30309@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 18 14:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxhiZ-0007Wi-8m
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 14:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735AbYERMJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 08:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757621AbYERMJb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 08:09:31 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:58944 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346AbYERMJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 08:09:30 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 May 2008 08:09:30 EDT
Received: from [84.176.87.78] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Jxhc1-0002tu-3B
	for git@vger.kernel.org; Sun, 18 May 2008 14:03:37 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82381>

Is it possible to see which commands are executed by git-gui?
For an example, there's a menu item "branch -> rename".
I'm not aware that such a thing as "git branch rename"
exists on the command line. So git-gui must do it by
other means. Is there a way to see how? (Don't stick with
this example, it's a general question.)
Some "--debug" or "--log" switch which logs the
commands to a logfile or so? I know I could examine the
sources but that's not convenient ;-)

It would be really cool when git-gui could show the command
in a different window *before* it is executed. Some database
frontends have an option "show SQL statement", but I think
that would be demanded too much.

    Dirk
