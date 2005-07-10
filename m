From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 14:40:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507101438230.17536@g5.osdl.org>
References: <20050709232955.B31045@flint.arm.linux.org.uk>
 <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org>
 <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org> <20050710075548.A11765@flint.arm.linux.org.uk>
 <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net> <20050710134624.B3279@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0507100942020.17536@g5.osdl.org> <20050710201504.A22477@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0507101228300.17536@g5.osdl.org> <20050710213209.B22477@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 23:45:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrjbV-0000v2-VX
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 23:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVGJVoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 17:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGJVmE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 17:42:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261260AbVGJVk3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 17:40:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6ALeCjA016296
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 14:40:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6ALeBF6002472;
	Sun, 10 Jul 2005 14:40:12 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050710213209.B22477@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, Russell King wrote:
>
> On Sun, Jul 10, 2005 at 01:03:30PM -0700, Linus Torvalds wrote:
> > Anyway, I pushed out the merge, so don't worry about your tree. But let's 
> > hold off on this partial thing for a while, ok?
> 
> Thanks, that's good news.  I was fearing having to reconstruct stuff.
> 
> Do you want me to re-populate linux-2.6-arm.git to be fully populated
> or are you happy for it to just grow the new objects as they become
> available?

We can try just letting it grow. That way I'll have more reason to try to 
make the partial-repo thing just work.

		Linus
