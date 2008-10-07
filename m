From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 6 Oct 2008 19:10:37 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810061909260.3208@nehalem.linux-foundation.org>
References: <20081003122727.GE10360@machine.or.cz> <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain>
 <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061246460.3208@nehalem.linux-foundation.org>
 <20081007015336.GU21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 04:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn23Q-00020c-13
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 04:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbYJGCKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 22:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbYJGCKx
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 22:10:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50750 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751747AbYJGCKx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 22:10:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m972AcC4013885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Oct 2008 19:10:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m972AbNT019236;
	Mon, 6 Oct 2008 19:10:38 -0700
In-Reply-To: <20081007015336.GU21650@dpotapov.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.435 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97655>



On Tue, 7 Oct 2008, Dmitry Potapov wrote:
> 
> It looks like you have changed your opinion since what you wrote half
> a year ago.

Back then, nobody had really complained and sent in a patch to make it 
optional.

That changes things. Once some user actually complains, and sends in a 
fix to make the whole dialog optional, I don't see why anybody would ever 
argue against such a patch being accepted.

		Linus
