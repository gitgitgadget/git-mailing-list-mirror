From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] GIT: Support [address] in URLs
Date: Wed, 21 Dec 2005 15:26:48 -0800 (PST)
Message-ID: <20051221.152648.122640664.davem@davemloft.net>
References: <7v1x065blx.fsf@assigned-by-dhcp.cox.net>
	<7v3bkm3vw4.fsf@assigned-by-dhcp.cox.net>
	<20051222.080828.28117009.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 00:26:53 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpDMC-0004E6-7x
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVLUX0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVLUX0s
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:26:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23010
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964981AbVLUX0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:26:47 -0500
Received: from localhost.localdomain
	([127.0.0.1] helo=localhost ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1EpDM9-0004uf-29; Wed, 21 Dec 2005 15:26:49 -0800
To: yoshfuji@linux-ipv6.org
In-Reply-To: <20051222.080828.28117009.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13914>

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: Thu, 22 Dec 2005 08:08:28 +0900 (JST)

> In article <7v3bkm3vw4.fsf@assigned-by-dhcp.cox.net> (at Wed, 21 Dec 2005 14:52:59 -0800), Junio C Hamano <junkio@cox.net> says:
> 
> > This is the second reply to Yoshifuji-san today that did not
> > come back to me from the list (but I did get it back from my ISP
> > due to BCCing myself), so I am resending.
> 
> I got all of them; with and without my Japanese name on To:.

The vger.kernel.org spam filter filters out all non-ascii character
sets.  We have to do this because Matti and myself do all of the
filtering by hand, and we do not understand so many languages as to be
able to make sensible filters for spam in languages such as Japanese,
Korean, Chinese, Russian, etc. so we just filter them all.

I've asked people, such as Yoshifuji-san, on a number of occaisions if
they would mind not including Japanese characters (even if it is their
name in their FROM: field) in postings to the lists.

As long as they continue to do so, replies to their postings will be
filterd when their From: field ends up in the body of the posting.  I
edit the Japanese characters out by hand when I make replies to such
postings, and that is why my responses show up.

This is a pain, but no better solutions have been suggested.  Before
anyone responds: 1) making the lists subscriber-only is not an option
2) Bayesian filters are hard to integrate into our setup but we are
exploring ways to make that a reality at some point nevertheless.
