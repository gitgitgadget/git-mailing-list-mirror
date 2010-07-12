From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Hi about the installer
Date: Mon, 12 Jul 2010 11:46:30 +0200
Message-ID: <201007121146.30642.trast@student.ethz.ch>
References: <4C3A4494.1080803@prolinux.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Horacio Miranda <hmiranda@prolinux.cl>
X-From: git-owner@vger.kernel.org Mon Jul 12 11:46:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYFay-0002hA-3u
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 11:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab0GLJqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 05:46:34 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28857 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab0GLJqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 05:46:34 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 12 Jul
 2010 11:46:32 +0200
Received: from thomas.localnet (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 12 Jul
 2010 11:46:32 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4C3A4494.1080803@prolinux.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150803>

Horacio Miranda wrote:
> Is not working :(
> 
> This link is death 
> https://git.wiki.kernel.org/index.php/MSysGit:InstallMSysGit

If you think "[it] is not working" is a valid error description, then
this page isn't for you.  As the first section says

  msysGit is the development environment to compile Git for Windows. [...]
                 ^^^^^^^^^^^^^^^^^^^^^^^

  msysGit is not Git for Windows [...]
             ^^^^^^^^^^^^^^^^^^^

  It is easy to see the difference: the installers for Git have the
  prefix Git-, the msysGit installers have the prefix
  msysGit-. [...]

You most likely want to install

 http://code.google.com/p/msysgit/downloads/detail?name=Git-1.7.0.2-preview20100309.exe&can=2&q=

and then read a *Git* tutorial such as

  http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
  http://book.git-scm.com/
  http://progit.org/

That being said, I can't find any dead links on the wiki page.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
