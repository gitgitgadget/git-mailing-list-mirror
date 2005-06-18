From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Fri, 17 Jun 2005 17:26:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506171725150.2268@ppc970.osdl.org>
References: <E1DjQza-0001wP-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 02:18:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjR2v-0004eL-32
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 02:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFRAYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 20:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFRAYK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 20:24:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261662AbVFRAYG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 20:24:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5I0NwjA028400
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 17 Jun 2005 17:23:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5I0Nv9f031292;
	Fri, 17 Jun 2005 17:23:57 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1DjQza-0001wP-00@gondolin.me.apana.org.au>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 18 Jun 2005, Herbert Xu wrote:
> 
> I don't know whether this is the cleanest, but this is one way:

Oh, wow.

One thing I have to say is that I've learnt a lot more shell tricks. 

Now I'll just have to unlearn them, so that I won't have nightmares.

		Linus
