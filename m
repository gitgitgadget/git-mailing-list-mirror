From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 13:08:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171306360.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>
 <20050417195742.D13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org>
 <20050417205149.E13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 22:08:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNG3U-0006tC-6W
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDQUKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDQUI6
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:08:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:55180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbVDQUG7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 16:06:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HK6ss4014692
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 13:06:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HK6rLE001554;
	Sun, 17 Apr 2005 13:06:53 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417205149.E13233@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Russell King wrote:
> 
> This will (and does) do exactly what I want.  I'll also read into the
> above a request that you want it in forward date order. 8)

No, I actually don't _think_ I care. In many ways I'm more used to
"reverse date order", because that's usually how you view a changelog
(with a pager, and most recent changes at the top).

Which one makes sense when asking me to merge? I don't know, and I don't
think it really even matters, but maybe we can add a "for now" to whatever 
decision you end up coming to?

		Linus
