From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 6 Oct 2008 12:47:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810061246460.3208@nehalem.linux-foundation.org>
References: <20081003122727.GE10360@machine.or.cz> <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain>
 <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 21:49:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmw4q-00067B-3z
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 21:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYJFTrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 15:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbYJFTrz
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 15:47:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35886 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752664AbYJFTrz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 15:47:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m96JlH2T007334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Oct 2008 12:47:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m96JlGFf002378;
	Mon, 6 Oct 2008 12:47:16 -0700
In-Reply-To: <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.436 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97618>



On Mon, 6 Oct 2008, Johannes Schindelin wrote:
>
> It is not a bug.

If it's unwanted functionality, that's a bug. That's kind of the whole 
(and only) difference between "bug" and "feature". Do people want it?

And Petr made it clear that he didn't want it. And I can certainly 
understand why - so it's not just some confused user. As such, it's 
clearly not a feature, and is clearly a bug.

			Linus
