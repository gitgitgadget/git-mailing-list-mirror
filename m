From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] denser delta header encoding
Date: Tue, 28 Jun 2005 23:07:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506282306420.14331@ppc970.osdl.org>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
 <7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org>
 <7virzxk9nd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506282244110.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506290146270.1667@localhost.localdomain>
 <7vacl9k8iz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 07:58:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnVai-0001Dl-1Y
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVF2GFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 02:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVF2GFj
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 02:05:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262438AbVF2GFd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 02:05:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5T65HjA024405
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 23:05:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5T65Gu7023004;
	Tue, 28 Jun 2005 23:05:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacl9k8iz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Junio C Hamano wrote:
> 
> Double Damn!!  Three people working on the same piece of code.

The good news is that I'm pushing out a linux-2.6.13-rc1 release, and will 
go to bed after that, so I'm done for the day. No more races with me ;)

		Linus
