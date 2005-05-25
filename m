From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 20:04:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> <7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org> <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 05:01:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dam95-0007sh-Tb
	for gcvg-git@gmane.org; Wed, 25 May 2005 05:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVEYDC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 23:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVEYDC7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 23:02:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:3037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262249AbVEYDC5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 23:02:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4P32qjA016001
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 20:02:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4P32p0h000598;
	Tue, 24 May 2005 20:02:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Junio C Hamano wrote:
>
> LT> Also, what language do you actually speak?
> 
> Japanese.

It is possible it is cultural. I certainly find it harder to read the 
"unexpected" way. 

But maybe it's just me. I also have a _really_ hard time with reading
"unless(x)" (aka "if (!(x))"), that perl programmers seem to use. 

		Linus
