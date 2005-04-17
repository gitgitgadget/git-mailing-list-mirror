From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 12:54:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171253030.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504171531180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:49:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFl4-00058i-C4
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVDQTwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVDQTwd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:52:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:51847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261444AbVDQTwc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:52:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HJqOs4013425
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 12:52:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HJqNgb032640;
	Sun, 17 Apr 2005 12:52:24 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504171531180.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Daniel Barkalow wrote:
> 
> Yours reads the whole commit history; I intentionally wrote mine to
> only read as far back as turns out to be necessary.

Yes. I'm not opposed to yours, I was just opposed to some of the things 
around it you did, so I wrote mine as a kind of place-holder. I'll happily 
take patches to turn it from a rally simple and stupid one into a more 
polished version.

		Linus
