From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: How to revert 'git reset' command
Date: Sat, 1 May 2010 10:41:14 +0400
Organization: '
Message-ID: <20100501064114.GA5643@screwed.box>
References: <1272692918690-4989146.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: paragkalra <paragkalra@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 08:50:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O86X8-0005zX-8n
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 08:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab0EAGuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 02:50:22 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:52421 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab0EAGuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 02:50:20 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2010 02:50:20 EDT
Received: from localhost (gpftor6.privacyfoundation.de [62.212.67.209])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 2F3B35A97;
	Sat,  1 May 2010 10:30:05 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <1272692918690-4989146.post@n2.nabble.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146080>

Como esta, paragkalra?

You may want to try to make a new commit:

git commit -a

Another way is to rerpair your Git history from your remote repository, if one exists

2010/04/30 22:48:38 -0700 paragkalra <paragkalra@gmail.com> => To git@vger.kernel.org :
p> I have just started learning - Git. Today while exploring Git, I executed
p> following:
p> 
p> git reset
p> 
p> Now 'git status' is showing some files under - 'Unstaged changes after
p> reset:'
p> 
p> How can I revert back the effect of - 'git reset'
p> 
73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
