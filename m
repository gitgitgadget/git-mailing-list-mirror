From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Wed, 10 Aug 2005 22:05:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> 
 <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>  <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
  <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>  <pan.2005.08.10.21.15.41.143251@smurf.noris.de>
  <pan.2005.08.10.22.11.25.242201@smurf.noris.de>  <46a038f9050810155642bb5580@mail.gmail.com>
  <20050810233953.GV28270@kiste.smurf.noris.de>  <E1E33Zb-0004dT-Bx@highlab.com>
 <46a038f90508102144358a4bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 07:06:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E35HA-0004cg-OM
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 07:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVHKFGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 01:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVHKFGm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 01:06:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750831AbVHKFGl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 01:06:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7B55ijA031640
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 Aug 2005 22:05:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7B55h5c000795;
	Wed, 10 Aug 2005 22:05:43 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508102144358a4bcf@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 11 Aug 2005, Martin Langhoff wrote:
> 
> Well, I doubt this problem lies with Debian.

Oh, it definitely does.

>				 GNU Interactive Tools is
> packaged for most (all?) distributions, and has been there for ages.

.. but no other distribution seems to install it.

The _only_ people who have ever even noticed are debian people.

That should clue somebody in.

The top man-page I found for GNU interactive tools says:

	A Set of Interactive Programs
	Edition 2.5, for GIT version 4.3.16
	January 1997

just let it die in peace.

		Linus
