From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [msysGit] Git for Windows 1.9.0 (fwd)
Date: Tue, 18 Feb 2014 00:52:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1402180049570.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 00:52:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFXzH-000055-ED
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 00:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbaBQXwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 18:52:31 -0500
Received: from mout-xforward.gmx.net ([82.165.159.12]:56789 "EHLO
	mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaBQXwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 18:52:30 -0500
X-Greylist: delayed 813 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2014 18:52:30 EST
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LnOve-1Wvmx03DQs-00hbLc
 for <git@vger.kernel.org>; Tue, 18 Feb 2014 00:52:28 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:j2sDWxENbKRB6Nc0IuV7ZiQQdq3wU0L9xz8IPgwdmHYsD/wFynS
 Uxr0FffGZhZ+jObuQZm8Hq35Vi63GelHIn/xXyZ0rSC+6CjeMivKpamCUqEFs2L0nXecvlN
 klv4RouSgOcaoKQdVZYKd3s7Uw1fktvOYpaayyL8MaDmvwTcZmNXI97IhO25iPTlYvzmtET
 RG6PGMMWrYs1bM3hPmLyw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242271>

Hopefully the Postfix Greylisting Policy Server will not try again to
greylist me, as it might however do without violating the RFC.

---------- Forwarded message ----------
Date: Tue, 18 Feb 2014 00:38:54 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: msysgit@googlegroups.com
Cc: git@vger.kernel.org
Subject: [msysGit] Git for Windows 1.9.0

Dear Git fanbois,

this announcement informs you that the small team of volunteers who keep
the Git ship afloat for the most prevalent desktop operating system
managed to release yet another version of Git for Windows:

Git Release Notes (Git-1.9.0-preview20140217)
Last update: 17 February 2013

Changes since Git-1.8.5.2-preview20131230

New Features
- Comes with Git 1.9.0 plus Windows-specific patches.
- Better work-arounds for Windows-specific path length limitations (pull
  request #122)
- Uses optimized TortoiseGitPLink when detected (msysGit pull request
  #154)
- Allow Windows users to use Linux Git on their files, using Vagrant
  http://www.vagrantup.com/ (msysGit pull request #159)
- InnoSetup 5.5.4 is now used to generate the installer (msysGit pull
  request #167)

Bugfixes
- Fixed regression with interactive password prompt for remotes using the
  HTTPS protocol (issue #111)
- We now work around Subversion servers printing non-ISO-8601-compliant
  time stamps (pull request #126)
- The installer no longer sets the HOME environment variable (msysGit pull
  request #166)
- Perl no longer creates empty sys$command files when no stdin is
  connected (msysGit pull request #152)

Ciao,
Johannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
