From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Tue, 26 Jul 2005 09:50:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507260949140.19309@g5.osdl.org>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de>
 <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org> <20050725234257.GC5680@kiste.smurf.noris.de>
 <Pine.LNX.4.58.0507251922310.6074@g5.osdl.org> <Pine.LNX.4.58.0507252028220.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 18:54:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxSgi-0002Z6-Te
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 18:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVGZQx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 12:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVGZQxP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 12:53:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261947AbVGZQvm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 12:51:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6QGp1jA030174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Jul 2005 09:51:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6QGoxqJ031594;
	Tue, 26 Jul 2005 09:51:00 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <Pine.LNX.4.58.0507252028220.6074@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Jul 2005, Linus Torvalds wrote:
> 
> David, how about a patch like this to cvsps? My very very limited testing
> seems to say that it does the right thing..

Hmm.. David Mansfields address is bouncing, and it's apparently not just 
that "cvsps" thing, since it says that the MX machine can't be looked up. 
Does anybody have an alternate address for him? All the ones I've seen so 
far with google are at the same failing "dm.cobite.com" address.

		Linus
