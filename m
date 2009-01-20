From: Chris Willard <chris@thewillards.co.uk>
Subject: Newbie Query
Date: Tue, 20 Jan 2009 19:19:52 +0000
Message-ID: <20090120191952.GA25322@uts.thewillards.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 20:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPMYr-0008RO-0L
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 20:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbZATTpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbZATTpY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 14:45:24 -0500
Received: from customermail2.easily.co.uk ([212.53.64.53]:47170 "EHLO
	customermail2.easily.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755659AbZATTpX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 14:45:23 -0500
X-Greylist: delayed 1514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jan 2009 14:45:23 EST
Received: from thewillards.plus.com ([84.92.199.66] helo=mail-gw.thewillards.co.uk)
	by customermail2.easily.co.uk with esmtpa (Exim 4.67)
	(envelope-from <chris@thewillards.co.uk>)
	id 1LPM8s-0007qD-S0
	for git@vger.kernel.org; Tue, 20 Jan 2009 19:20:06 +0000
Received: from uts.thewillards.local (unknown [192.168.99.254])
	by mail-gw.thewillards.co.uk (Postfix) with ESMTP id CF533286F9
	for <git@vger.kernel.org>; Tue, 20 Jan 2009 19:15:58 +0000 (GMT)
Received: by uts.thewillards.local (Postfix, from userid 1000)
	id 26BAAFAE10D; Tue, 20 Jan 2009 19:19:52 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-THEWILLARDS-MailScanner-ESVA-Information: Please contact  for more information
X-THEWILLARDS-MailScanner-ESVA-ID: CF533286F9.99E25
X-THEWILLARDS-MailScanner-ESVA: Found to be clean
X-THEWILLARDS-MailScanner-ESVA-From: chris@thewillards.co.uk
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106512>

Hello All,

I am having a go at using git and need a bit of help.

I have git installed on my laptop and on my pc. I created some files
on the pc then used git close via ssh to put them on my laptop - all
OK so far!

I then modified the files, added them, commited the changes and then
used git push to put them on the PC - still no problems.

Both systems show the commits but the PC does not have the latest
version of the files. Git status on the PC shows the file as changed
but commiting give an error when pushing from the laptop. 

I assume that I need to run a command on the PC to get both systems
the same. Is it a reset or something else? 


Regards,



Chris

-- 
... "Even the gods did not spring into being overnight." Spock

--
This message was scanned by ESVA and is believed to be clean.
