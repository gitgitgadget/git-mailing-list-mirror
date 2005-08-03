From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 08:09:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 17:10:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0KsQ-0002mV-OZ
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 17:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVHCPJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 11:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVHCPJp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 11:09:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262303AbVHCPJp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 11:09:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73F9XjA028844
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 08:09:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73F9Wpb022685;
	Wed, 3 Aug 2005 08:09:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 2 Aug 2005, Junio C Hamano wrote:
> 
> How about git-rev-tree?  Does anybody care?

Yeah, probably not. git-rev-list does so much more than git-rev-tree ever 
did.

		Linus
