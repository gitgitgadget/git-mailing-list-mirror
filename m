From: Long <gimmely@gmail.com>
Subject: Re: v2.5.2 installation on Windows 10
Date: Sat, 12 Sep 2015 14:35:33 +0000 (UTC)
Message-ID: <loom.20150912T162911-432@post.gmane.org>
References: <loom.20150911T181145-207@post.gmane.org> <a64946ac120a98fc1058bd194153cd0b@dscho.org> <01a501d0ed50$48b19ab0$da14d010$@gmail.com> <9fdf16cff4e2468a3a013ac2f13ac060@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 16:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaluZ-0005Om-8M
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 16:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbbILOft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 10:35:49 -0400
Received: from plane.gmane.org ([80.91.229.3]:59393 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbbILOfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 10:35:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Zalu6-0004op-ER
	for git@vger.kernel.org; Sat, 12 Sep 2015 16:35:46 +0200
Received: from c-50-182-235-108.hsd1.nj.comcast.net ([50.182.235.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 16:35:46 +0200
Received: from gimmely by c-50-182-235-108.hsd1.nj.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 16:35:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 50.182.235.108 (Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277727>

Hi Johannes,

Johannes Schindelin <johannes.schindelin <at> gmx.de> writes:

> 
> Hi Long,
> 
> On 2015-09-12 13:43, Long Yang wrote:
> 
> > Thanks for the email to confirm the bug.
> 
> Of course! Thank you for taking the time to report it.
> 
> > To answer your question first, I found only the Community page at
> > http://www.git-scm.com/, as I was looking for a forum-kind of page to
> > see if someone had reported the same problem I had.  Then I tried to
> > send a couple of emails to the mailing list, git <at> vger.kernel.org, as
> > instructed on the Community page.  But none of my emails was
> > delivered.  At the end, I post my case via gmane.
> 
> Thank you, I think I will open a Pull Request to that Community page to
suggest going the GitHub issues route
> in case of Windows-specific bugs.
> 
> > In short, I still don't know how to successfully report a bug for Git.
> >  Should I/users use GitHub?
> 
> If the bug in question is a Windows-specific bug, or if you do not know
whether it is a Windows-specific bug,
> then yes, please submit it to our GitHub issue tracker, as described in
the "Contribute" section of our
> home page: http://git-for-windows.github.io/#contribute
> 
> If you already know that the bug in question affects more than just
Windows users, please report it to the Git
> mailing list, as you have done. (You will need to send plain-text
messages, as the Git mailing list rejects
> HTML mails.)
> 

I guess my emails were rejected due to HTML, as I'm using Outlook with HTML
default.

I'll try to follow the instructions on reporting bugs going forward.

> Ciao,
> Johannes
> 

"Another" issue I'm seeing now is that, as I mentioned in a follow-up post
to another person's on this problem, Git commands are not showing in Windows
Explorer (via right-click).  I've installed TortoiseGit and seen the
same/similar "issue" with its commands too.  Especially, TortoiseGit doesn't
show a command to create a repository, which I don't know is with Git or the
communication between Git v2.5.2 and TortoiseGit.


Long
