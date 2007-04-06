From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Distinguish branches by more than case in tests.
Date: Fri, 6 Apr 2007 16:41:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704061637280.6730@woody.linux-foundation.org>
References: <20070406054204.GA13108@Hermes.local> <7v7ispjhtx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704061502000.6730@woody.linux-foundation.org>
 <86mz1lt8bg.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZy3W-0001sd-3J
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 01:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413AbXDFXlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 19:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933410AbXDFXlR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 19:41:17 -0400
Received: from smtp.osdl.org ([65.172.181.24]:38799 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933413AbXDFXlP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 19:41:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l36NfAPD022872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Apr 2007 16:41:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l36Nf9qC022792;
	Fri, 6 Apr 2007 16:41:09 -0700
In-Reply-To: <86mz1lt8bg.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=-2.453 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43941>



On Fri, 6 Apr 2007, Randal L. Schwartz wrote:
> 
> Just playing the devil's advocate (I prefer the clean filesystem of Unix), the
> argument the case-folding fans make is "well, taxes and TAXES is the same
> word, right?".

And "polish" and "Polish" is the same word, right? AnD i cOuLD wRite 
THInGs LiKE thiS, aND it WouLd bE eaSiER tO REad, RiGHt?

Case *does* matter. Anybody who claims otherwise is a total idiot.

And no, e e cummings is not an example to the contrary. Quite the reverse. 
Even people like e e cummings (known for his lack of capitalization) 
actually became well-known exactly because he made capitalization *matter* 
by flouting the rules (the same way he also flouted the rules of grammar 
and other word usage!).

		Linus
