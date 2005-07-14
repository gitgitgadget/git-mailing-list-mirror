From: James Cloos <cloos+vger-git@jhcloos.com>
Subject: Re: cg update failing
Date: Thu, 14 Jul 2005 17:50:15 -0400
Message-ID: <m3d5plm50o.fsf@lugabout.cloos.reno.nv.us>
References: <m3oe95qn64.fsf@lugabout.cloos.reno.nv.us>
	<1121365461.4729.0.camel@localhost.localdomain>
	<m3k6jtnod8.fsf@lugabout.cloos.reno.nv.us>
	<1121376069.4729.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 23:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtBev-0008MA-Eq
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 23:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVGNVxm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 17:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVGNVvb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 17:51:31 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:9220 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261746AbVGNVu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 17:50:26 -0400
Received: from lugabout.jhcloos.org (host-69-48-10-3.roc.choiceone.net [69.48.10.3])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP
	id 135FE1D02F; Thu, 14 Jul 2005 16:50:21 -0500 (CDT)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id C891C1483BB; Thu, 14 Jul 2005 21:50:15 +0000 (GMT)
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1121376069.4729.2.camel@localhost.localdomain> (Darrin Thompson's message of "Thu, 14 Jul 2005 16:21:09 -0500")
X-Hashcash: 1:21:050714:darrint@progeny.com::XIWaHj4+nitXRQ8u:0000000000000000000000000000000000000000001c/1
X-Hashcash: 1:21:050714:git@vger.kernel.org::eTXjoQuvOZftza3a:000000000000000000000000000000000000000000K6Vo
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "Darrin" == Darrin Thompson <darrint@progeny.com> writes:

Darrin> Now your merge should not be blocked. No?

I figured out what you meant after I sent that first reply, but waited
for update to finish to be sure it worked before replying again.

It took about thirty minutes, and claimed that I had local changes (it
was a pristine clone) that it needed to bring forward, but it seems OK.

Now I just need to remember how to get the checked-out copy
updated from the 2.6.12 tag to current. ;)

(I'd been using hg, but www.kernel.org/hg is fubar, so I had to go
back to my cg clone.)

-JimC
