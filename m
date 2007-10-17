From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 15:03:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171438551.26902@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <1192645509.6640.21.camel@athena> <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
 <1192649598.6640.44.camel@athena> <alpine.LFD.0.999.0710171246500.26902@woody.linux-foundation.org>
 <20071017232146.4b9e4097@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
X-From: git-owner@vger.kernel.org Thu Oct 18 00:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiH0K-00069c-K1
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 00:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbXJQWE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 18:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbXJQWE3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 18:04:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59661 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755975AbXJQWE2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 18:04:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HM3ukO030669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 15:03:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HM3tVG010539;
	Wed, 17 Oct 2007 15:03:55 -0700
In-Reply-To: <20071017232146.4b9e4097@localhost.localdomain>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61431>



On Wed, 17 Oct 2007, Christer Weinigel wrote:
> 
> But when you start claiming that there are no reasons to use all
> spaces, and that it doesn't solve any problems (it definitely does),
> and that all editors work with hard tabs at 8 (which they don't), at
> least I get a bit frustrated with you.  It's very non-respectful of you
> to claim that everyone is stupid that doesn't agree with you and is
> just asking for silly arguments.  Yes, I know, you're an opinionated
> bastard and proud of it, but maybe you should tone that down a bit.

Hey, fair enough. 

I'm not very tolerant of people who haven't actually done anything, and 
then come in and say things should be done certain ways. The fact is, code 
talks, bullshit walks. 

And bullshit should most definitely not be encouraged. People like that 
should be discouraged *immediately*. I'm not interested in bikeshed 
painters, I think they should be told so forcefully enough that they 
either shut up or go away. 

Maybe it's a character flaw. I'll respect people who do something 
interesting, but re-implementing CVS (and badly, at that) or talking about 
syntactic changes to other peoples projects is not going to fill me with 
respect.

In short, I'll give respect when somebody is shown to be *worth* that 
respect. But respect really has to be earned, not just "assumed", 
otherwise it's pointless.

			Linus
