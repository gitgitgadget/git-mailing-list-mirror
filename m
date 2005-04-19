From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] provide better committer information to commit-tree.c
Date: Mon, 18 Apr 2005 17:31:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org>
References: <20050419001126.GB21170@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 02:26:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgYi-0003YO-Bb
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVDSA3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVDSA3b
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:29:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:12496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261217AbVDSA3X (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 20:29:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3J0TJs4014752
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 17:29:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3J0TISR014088;
	Mon, 18 Apr 2005 17:29:19 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050419001126.GB21170@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Greg KH wrote:
>
> Here's a small patch to commit-tree.c that does two things:

Gaah, I really was hoping that people wouldn't feel like they have to lie 
about their committer information.

I guess we don't have much choice, but I'm not happy about it.

		Linus
