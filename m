From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 14:53:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508111448090.3295@g5.osdl.org>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
 <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
 <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de>
 <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de>
 <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com>
 <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com>
 <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 23:53:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3KzQ-0006yQ-0J
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 23:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVHKVxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 17:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVHKVxZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 17:53:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932267AbVHKVxY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 17:53:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7BLr6jA009443
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Aug 2005 14:53:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7BLr5tO014238;
	Thu, 11 Aug 2005 14:53:05 -0700
To: Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <E1E3IOG-0005HO-AK@highlab.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.43__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 11 Aug 2005, Sebastian Kuzminsky wrote:
> 
> What I have is bug reports against the cogito package, from people who
> want to install both.  The reports came very soon after I released the
> package, so I dont think it's a totally freak occurance.

The point is, people have the thing _installed_, because apparently it
comes as default with a full debian install. That doesn't mean they 
actually use them - they're complaining because they get a "this clashes 
with that" error.

At least that's the only comment I've ever gotten: people that say that
they had the old git installed. None of the ones that contacted me said
that they had actually ever _used_ it.

Hands up people. Does anybody _use_ GNU interactive tools? None of this "I 
have a package" crap.

		Linus
