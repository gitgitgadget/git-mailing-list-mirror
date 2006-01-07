From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Fri, 6 Jan 2006 16:10:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601061603330.3169@g5.osdl.org>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
 <7vek3lq8wu.fsf@assigned-by-dhcp.cox.net> <86wthd7ypx.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0601061525100.3169@g5.osdl.org> <86psn49alm.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 01:10:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev1fL-0006yh-L0
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 01:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965365AbWAGAKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 19:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbWAGAKg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 19:10:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965365AbWAGAKg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2006 19:10:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k070AJDZ016301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Jan 2006 16:10:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k070AGqY020396;
	Fri, 6 Jan 2006 16:10:16 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86psn49alm.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14231>



On Fri, 6 Jan 2006, Randal L. Schwartz wrote:
> 
> Linus> I just hope you don't cross-breed. Shudder.
> 
> Don't worry.  So far, I haven't had any offers.

I was more worried about the "collective" of perl people, not any 
particular individual developer.

If it was just you, I could just poison you over lunch some time..

Which reminds me - you owe me lunch. A non-poisoned one.

		Linus
