From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk "hyperlinks" (was Re: Display of merges in gitk)
Date: Sat, 6 Aug 2005 08:44:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508060839500.3258@g5.osdl.org>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org> <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
 <20050806033654.GA27953@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 17:44:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1Qqg-0006ET-D5
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 17:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbVHFPoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 11:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbVHFPoQ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 11:44:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263222AbVHFPoP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 11:44:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j76FiBjA019376
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Aug 2005 08:44:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j76FiAhr020410;
	Sat, 6 Aug 2005 08:44:10 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050806033654.GA27953@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 6 Aug 2005, Kay Sievers wrote:
> 
> Damn cool? No problem. :)
>   http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=403fe5ae57c831968c3dbbaba291ae825a1c5aaa

Goodie. Although when I looked at it first, it wasn't obvious - the link
is same font, same color as the rest. Maybe make them stand out a _bit_
more?

But yes, works well. Thanks,

		Linus
