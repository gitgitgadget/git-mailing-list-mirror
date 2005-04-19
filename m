From: Russell King <rmk@arm.linux.org.uk>
Subject: More git pull problems
Date: Tue, 19 Apr 2005 08:02:51 +0100
Message-ID: <20050419080251.A11988@flint.arm.linux.org.uk>
References: <E1DNlmx-00029W-L2@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 08:59:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNmhH-0005pF-PE
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 08:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVDSHC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 03:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDSHC7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 03:02:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19209 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261357AbVDSHCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 03:02:55 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNml2-0001Xc-LR
	for git@vger.kernel.org; Tue, 19 Apr 2005 08:02:53 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNml1-0003CS-Fl
	for git@vger.kernel.org; Tue, 19 Apr 2005 08:02:51 +0100
To: Git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1DNlmx-00029W-L2@flint.arm.linux.org.uk>; from src@flint.arm.linux.org.uk on Tue, Apr 19, 2005 at 07:00:47AM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

My automatic pull this morning produced the following messages, which
seem to indicate that something's up with git pull now.

git-pasky-0.4 (7bef49b5d53218ed3fa8bac291b5515c6479810c)

> MOTD:	
> MOTD:	Welcome to the Linux Kernel Archive.
> MOTD:	
> MOTD:	Due to U.S. Exports Regulations, all cryptographic software on this
> MOTD:	site is subject to the following legal notice:
> MOTD:	
> MOTD:	This site includes publicly available encryption source code
> MOTD:	which, together with object code resulting from the compiling of
> MOTD:	publicly available source code, may be exported from the United
> MOTD:	States under License Exception "TSU" pursuant to 15 C.F.R. Section
> MOTD:	740.13(e).
> MOTD:	
> MOTD:	This legal notice applies to cryptographic software only.
> MOTD:	Please see the Bureau of Industry and Security,
> MOTD:	http://www.bis.doc.gov/ for more information about current
> MOTD:	U.S. regulations.
> MOTD:	
> 
> 
> rsync: link_stat "/linux/kernel/people/torvalds/sparse.git/tags" (in pub) failed: No such file or directory (2)
> rsync error: some files could not be transferred (code 23) at main.c(723)
> 
> client: nothing to do: perhaps you need to specify some filenames or the --recursive option?
> New branch: 945a2562ee9e632bc6b3399fd49e028c39d19023
> Tracked branch, applying changes...
> Fast-forwarding 945a2562ee9e632bc6b3399fd49e028c39d19023 -> 945a2562ee9e632bc6b3399fd49e028c39d19023
> 	on top of 945a2562ee9e632bc6b3399fd49e028c39d19023...
> gitdiff.sh: trying to diff 67607f05a66e36b2f038c77cfb61350d2110f7e8 against itself

-- 
Russell King

