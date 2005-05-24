From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 14:43:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241443400.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
 <20050524202846.GC25606@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org> <20050524213102.GB19180@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:42:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dah91-0002Xi-Te
	for gcvg-git@gmane.org; Tue, 24 May 2005 23:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVEXVmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVEXVmH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 17:42:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:5248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261349AbVEXVmC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 17:42:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OLftjA026102
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 14:41:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OLfrlv019395;
	Tue, 24 May 2005 14:41:54 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050524213102.GB19180@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Kay Sievers wrote:
> 
> What about allowing to put some file inside of .git/ under revision-control
> too? Wouldn't it be nice to have something like an "ignore" file or other
> repository meta-data managed by git itself.

Put them into ".git-ignore" if so..

		Linus
