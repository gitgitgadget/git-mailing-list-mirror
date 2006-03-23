From: sean <seanlkml@sympatico.ca>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 13:12:00 -0500
Message-ID: <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
References: <20060322133337.GU20746@lug-owl.de>
	<Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	<Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	<44223B90.3040500@zytor.com>
	<1143128751.6850.35.camel@neko.keithp.com>
	<Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: keithp@keithp.com, hpa@zytor.com, jbglaw@lug-owl.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 19:15:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMUKc-0007dt-Ew
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 19:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWCWSOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 13:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbWCWSOY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 13:14:24 -0500
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:10897 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1422639AbWCWSOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 13:14:23 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 23 Mar 2006 10:15:36 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E8F9A644C28;
	Thu, 23 Mar 2006 13:14:21 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060323131200.02c535b8.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 Mar 2006 18:15:37.0062 (UTC) FILETIME=[C8B6A060:01C64EA5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Mar 2006 08:01:14 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> I have to say, that one thing I've learnt during this whole git thing is 
> that other SCM's are DAMN CONFUSED.
> 
> I used to think that git was potentially hard to understand. Not so. git 
> is an absolute paragon of logic and easy-to-understand concepts.
> 
> Compared to SVN (can anybody sat "trunk/branch/tag confusion") and CVS, 
> git is not only a hell of a lot more capable, it's just more logical.
> 
> We will hereby start scouring the net for people who say git is hard to 
> understand and use, and just kill them. They clearly are just polluting 
> the gene pool.

lol, that sounds like a really good plan.  Perhaps as a two pronged effort
its worth changing the notion that git is primarily "plumbing".   Adding
some of the nice features of cogito and other "porcelains" into the core
git might go a ways toward converting the few naysayers we don't kill.

Sean
