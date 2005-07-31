From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 15:50:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507311549300.14342@g5.osdl.org>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.58.0507311305170.29650@g5.osdl.org> <7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 00:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzMlC-0003HS-NR
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 00:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVGaWwu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 18:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVGaWul
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 18:50:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262037AbVGaWub (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 18:50:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6VMoMjA015464
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 31 Jul 2005 15:50:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6VMoLk9007008;
	Sun, 31 Jul 2005 15:50:21 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 31 Jul 2005, Junio C Hamano wrote:
> 
> But you are.  I can run this just fine:

No I'm not. Try all the machines behind my firewall.

kernel.org is just the place I put things to when I publish them. It 
doesn't have any of my working directories on it.

			Linus
