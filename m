From: "Rainer Lauer" <lauerr@gmx.net>
Subject: Challenge with Git-Bash
Date: Sat, 17 Jul 2010 18:20:04 +0200
Message-ID: <001d01cb25cb$eb176980$c1463c80$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Rainer Lauer'" <lauerr@gmx.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 17 18:20:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaA7q-0001Pk-AJ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab0GQQUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 12:20:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:54889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756094Ab0GQQUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 12:20:11 -0400
Received: (qmail invoked by alias); 17 Jul 2010 16:20:09 -0000
Received: from pD9E09ADD.dip.t-dialin.net (EHLO Workstation) [217.224.154.221]
  by mail.gmx.net (mp062) with SMTP; 17 Jul 2010 18:20:09 +0200
X-Authenticated: #9219177
X-Provags-ID: V01U2FsdGVkX18wCARQLOQwAB0DyM1LoSLnwo61j+Wlk4StPL0F2t
	OJGyNbxnCnDEhH
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Acsly+omN2A8ZS5PSiyW+PUbP2saiQ==
Content-Language: de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151191>

Hello,
with my Windows 7 Git-Installation I get following challenge:
1)	Set GIT_EDITOR to editor of your choice
2)	With Windows7 let this editor run in admin-mode
	Goto .exe-file -> right mouse-click -> compatibility -> run program
as admin (I'm running a German version maybe English names are slightly
different)
3)	Make a git action like git add file
                             git commit
	from the git bash.
4)	Now following message appears:  sh.exe: ./"editor of your choice":
Bad file number
Everything is fine without Admin-Mode set for editor. In other words if you
get rid of step 2) step 4) doesn't appear instead the editor starts.
Due to other tasks my editor of choice has to run in this mode - stupid
enough.

Any chance to get around this problem?
(No not taking a different editor, no not getting rid of admin mode :) )

Reggies,
Rainer Lauer
