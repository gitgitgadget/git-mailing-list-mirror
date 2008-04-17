From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 21:53:01 +0100
Message-ID: <20080417205301.GG27459@ZenIV.linux.org.uk>
References: <47FEADCB.7070104@rtr.ca> <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com> <48078323.4010109@davidnewall.com> <200804172109.35027.rjw@sisk.pl> <2c0942db0804171235o49238b99u6cdbd3e5c8d6ebb7@mail.gmail.com> <20080417201657.GF27459@ZenIV.linux.org.uk> <2c0942db0804171338p7bc7d9f2u8079c2f8c8998e76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	David Newall <davidn@davidnewall.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@namei.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
X-From: netdev-owner@vger.kernel.org Thu Apr 17 23:10:08 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmb7e-0007qr-4p
	for linux-netdev-2@gmane.org; Thu, 17 Apr 2008 22:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbYDQUxM (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Thu, 17 Apr 2008 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbYDQUxK
	(ORCPT <rfc822;netdev-outgoing>); Thu, 17 Apr 2008 16:53:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48716 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbYDQUxJ (ORCPT
	<rfc822;netdev@vger.kernel.org>); Thu, 17 Apr 2008 16:53:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.68 #1 (Red Hat Linux))
	id 1Jmb6M-0007y8-0o; Thu, 17 Apr 2008 21:53:02 +0100
Content-Disposition: inline
In-Reply-To: <2c0942db0804171338p7bc7d9f2u8079c2f8c8998e76@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79823>

On Thu, Apr 17, 2008 at 01:38:18PM -0700, Ray Lee wrote:
> >         And frankly, that's the only thing that matters anyway; I suspect
> >  I'd do rather well by proposed criteria, but you know what?  I don't give
> >  a flying f*ck through the rolling doughnut for self-appointed PHBs and
> >  their idea of performance reviews.
> 
> (Geez, conflate the issue much?) No one is saying you should. But
> also, I haven't seen anyone saying it'd be used for performance
> reviews other than you.

|| If there are individuals at whom a finger needs to be pointed, this  
|| system will highlight them, and fingers will (and should) be pointed.
|| Contributors of poor-quality code need to be weeded-out.

in this thread (From: David Newall).

> <shrug> Shame and Guilt, two major motivators of human behavior, it's
> true. But, one last time, *you're* the one saying the stats would be
> used for finger pointing at people.

Not really.  Unless you are trying to imply that David is my sock puppet, that
is...
