From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] list shortlog items in commit order
Date: Tue, 2 Aug 2005 21:59:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508022158290.3341@g5.osdl.org>
References: <Pine.LNX.4.63.0508021713230.15300@localhost.localdomain>
 <7vvf2oklwy.fsf@assigned-by-dhcp.cox.net> <42F040E1.5000706@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 07:01:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0BN1-0004M0-U4
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 07:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVHCE7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 00:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVHCE7u
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 00:59:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbVHCE7o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 00:59:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j734xPjA019281
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 2 Aug 2005 21:59:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j734xO3g027275;
	Tue, 2 Aug 2005 21:59:25 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42F040E1.5000706@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 2 Aug 2005, Jeff Garzik wrote:
> 
> <shrug>  I don't really care either way.

I suspect it's mostly the users, not the developers, who care. The core
developers already know what went in, and have git to see it, they don't 
look at the shortlog output. So I suspect it's more important to see if 
there's user feedback one way or the other..

		Linus
