From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add NO_CURL option to the Makefile
Date: Sat, 30 Jul 2005 21:12:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507302110170.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507310213110.13590@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vk6j7ye6b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 06:13:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz5Cq-00019c-N6
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 06:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGaENf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 00:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbVGaENc
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 00:13:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261545AbVGaEND (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 00:13:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6V4CujA003150
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 21:12:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6V4Ct2P029339;
	Sat, 30 Jul 2005 21:12:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6j7ye6b.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Jul 2005, Junio C Hamano wrote:
> 
> I love it I can just slow down and let others submit obviously
> correct patches, which I can just slurp in.

You're obviously doing well as a maintainer. Only stupid people try to do 
everything themselves.

Personally, I spend a _lot_ of time communicating, because even if it's a 
lot more work to explain (in detail) what I want done, and it doesn't work 
out all the time, and I sometimes have to do it myself _anyway_, if it 
works even just occasionally, it not only gets people involved, it makes 
them do it themselves next time around without prodding, and then you just 
sit back, sip a foofy tropical drink, and take the credit.

		Linus
