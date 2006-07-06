From: "Aaron Gray" <angray@beeb.net>
Subject: Why's Git called Git ?
Date: Thu, 6 Jul 2006 03:18:12 +0100
Message-ID: <01f201c6a0a2$6faa0f80$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 06 04:18:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyJRe-00008o-ER
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 04:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWGFCSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 22:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWGFCSS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 22:18:18 -0400
Received: from lon1-mail-2.visp.demon.net ([193.195.70.5]:5917 "EHLO
	lon1-mail-2.visp.demon.net") by vger.kernel.org with ESMTP
	id S965134AbWGFCSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 22:18:18 -0400
Received: from AMD2500 (mwgray.force9.co.uk [212.159.110.144])
	by lon1-mail-2.visp.demon.net (MOS 3.5.8-GR)
	with ESMTP id EEG43602 (AUTH angray);
	Thu, 6 Jul 2006 03:18:15 +0100 (BST)
To: "Git Mailing List" <git@vger.kernel.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23368>

>> I am toying with using a VCS for a set of related projects, either CVS
>> because its well known, SubVersion for ease of use, or Git as it is new.
>> Lots to descide upon, any pointers would be appreciated.
>
> CVS is showing it's age; mainly the fact that IIRC it began as a series of
> scripts over RCS, file level version control system, extending version
> control to sets of files, somewhat. Branching in CVS is serious PITA.
> Renaming _with_ retaining full and correct history: forget about it.

Okay, we like branching and forking.

> Subversion is "better CVS": still centralized, CVS infernal branching
> replaced by "cheap copy" branching. Well known, replaces CVS thorough OSS
> projects.

Okay.

> Git, Mercurial, Monotone, Bazaar-NG, Darcs are new brand of distributed 
> VCS.
> I really like notion of branching in Git; but be warned about tracking and
> not recording renames, and the need of explicit packing (the latter very
> minor). Powerfull, perhaps too powerfull for newbie user: but that is what
> Cogito is for (although now Git contains fairly large set of high-level
> commands).

We like to move forward.

>
>  http://git.or.cz/
>  http://git.or.cz/gitwiki
>  http://git.or.cz/gitwiki/Git
> and "Other version control software" at
>  http://git.or.cz/gitwiki/GitLinks


Yes, been there, thanks though.

> P.S. If you decide to use Git as VCS for your project, consider adding 
> entry
> about it on http://git.or.cz/gitwiki/GitProjects wiki page.

Looks like I maybe doing a preliminary Windows Git HOWTO on the GitWiki, if 
no one else has trod this ground :) (Might need some proper help testing 
though)

Thanks,

Aaron
