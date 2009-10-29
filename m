From: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
Subject: msysgit won't install as per instructions
Date: Thu, 29 Oct 2009 12:38:36 +0000
Message-ID: <DyCV4WDMzY6KFwha@thewolery.demon.co.uk>
Reply-To: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;charset=us-ascii;format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 13:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3UIZ-0002Zz-NI
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 13:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZJ2Mj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 08:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZJ2Mj6
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 08:39:58 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:40160 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752392AbZJ2Mj5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 08:39:57 -0400
Received: from dyn-62-56-51-120.dslaccess.co.uk ([62.56.51.120] helo=thewolery.demon.co.uk)
	by lon1-post-2.mail.demon.net with esmtpa (AUTH thewolery)
	(Exim 4.69)
	id 1N3UIM-0007by-as
	for git@vger.kernel.org; Thu, 29 Oct 2009 12:40:02 +0000
User-Agent: Turnpike/6.07-M (<UIe6Thl4PTCai3mvYGa+2+ugZs>)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131586>

I want to do some work on git-daemon under msysgit. And as a newbie to 
git it could well be I'm just being stupid, but ...

I installed msysgit, did a clone on the msysgit repository, and followed 
the instructions, namely double-click on msys.bat. It falls over with 
"no target for make install" - I know make well enough to know that 
*sounds* *like* a messed up makefile. But lack of experience means 
trying to track how it got there defeats me. The error output is below.

Cheers,
Wol


-------------------------------------------------------
Building and Installing Git
-------------------------------------------------------
make: *** No rule to make target `install'.  Stop.


-------------------------
Hello, dear Git developer.

This is a minimal MSYS environment to work on Git.

Your build failed...  Please fix it, and give feedback on the Git list.

Welcome to msysGit


Run 'git help git' to display the help index.
Run 'git help <command>' to display help for specific commands.
Run '/share/msysGit/add-shortcut.tcl' to add a shortcut to msysGit.
bash: /git/contrib/completion/git-completion.bash: No such file or 
directory
bash: __git_ps1: command not found
-- 
Anthony W. Youngman - anthony@thewolery.demon.co.uk
