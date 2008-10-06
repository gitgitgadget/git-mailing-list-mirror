From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 6 Oct 2008 10:34:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org>
References: <20081003122727.GE10360@machine.or.cz> <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain>
 <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 19:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmu02-0002CH-P1
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYJFRed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYJFRed
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:34:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33061 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599AbYJFRec (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 13:34:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m96HYNCh030746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Oct 2008 10:34:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m96HYNDn029751;
	Mon, 6 Oct 2008 10:34:23 -0700
In-Reply-To: <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.435 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97610>



On Mon, 6 Oct 2008, Johannes Schindelin wrote:
> 
> Well, I consider it a courtesy to the msysGit people to leave it where 
> it is.

Umm. I consider it to be UNACCEPTABLY STUPID to claim "courtesy" if it 
actually makes something just more irritating to users.

I absolutely detest clicking through EULA's or other self-serving crap. I 
hate software that bothers me with their license details. Nobody reads 
those things anyway, and an extra click or an extra window I didn't ask 
for - _especially_ in open source software - is just a bug.

Bugs aren't "courtesy". Not to the user, and certainly not to the 
developer.

			Linus
