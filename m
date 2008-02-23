From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Improved Google trends comparison
Date: Sat, 23 Feb 2008 14:21:56 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802231407210.21332@woody.linux-foundation.org>
References: <332FA266-4D12-4ED4-9B38-44577E1E540B@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT2lr-00038Z-M1
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbYBWWWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756496AbYBWWWF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:22:05 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:60241 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756216AbYBWWWE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2008 17:22:04 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1NMLv97031404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Feb 2008 14:21:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1NMLuUc017611;
	Sat, 23 Feb 2008 14:21:56 -0800
In-Reply-To: <332FA266-4D12-4ED4-9B38-44577E1E540B@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.495 required=5 tests=AWL,BAYES_05
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74864>



On Sat, 23 Feb 2008, Rhodes, Kate wrote:
>
> Jakub was commenting on relative VCS popularity just after the 1.5.4 release.
> This is just an improved (i hope) version of his Google trends link that
> includes the alternate names for subversion, mercurial, and bazaar.
> 
> http://www.google.com/trends?q=svn%7Csubversion%2C+git%2C+mercurial%7Chg%2C+bzr%7Cbazaar%2C+darcs&ctab=0&geo=all&date=all&sort=0

LOL. Most of these seem totally unrelated to VCS's.

Most of the news that it finds for those "trends" for git are for things 
like Larry the cable guy's "git-r-done" thing (and "Two more Git-N-GO 
stores robbed". I'm not sure that's really relevant to the SCM ;)

Similarly, your bzr|bazaar seems to be all about the "bazaar" part, not 
about the SCM itself (drop "bazaar" from there, and the trends are very 
different, especially for that huge peak in India).

And "hg" seems to be about HG Wells and HG BISSINGER and Sandisk/Sony 
"Memory Stick Pro-HG" Format, based on the news hits and on the fact that 
the "trend" has actually stayed fairly constant since 2004, and since hg 
the VCS was started in 2005, it's either a sign of finding something else, 
_or_ about the incredible prescient powers of internet users.

But the SVN hits might actually be about subversion.

So if you do just the trend for bzr and svn, I think you have something. 

			Linus
