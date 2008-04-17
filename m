From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 21:16:57 +0100
Message-ID: <20080417201657.GF27459@ZenIV.linux.org.uk>
References: <47FEADCB.7070104@rtr.ca> <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com> <48078323.4010109@davidnewall.com> <200804172109.35027.rjw@sisk.pl> <2c0942db0804171235o49238b99u6cdbd3e5c8d6ebb7@mail.gmail.com>
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
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755642AbYDQUR2@vger.kernel.org Thu Apr 17 22:41:21 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755642AbYDQUR2@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmaYe-0005xV-7v
	for glk-linux-kernel-3@gmane.org; Thu, 17 Apr 2008 22:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbYDQUR2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Apr 2008 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbYDQURM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2008 16:17:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54736 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbYDQURK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2008 16:17:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.68 #1 (Red Hat Linux))
	id 1JmaXR-0005ks-Ap; Thu, 17 Apr 2008 21:16:57 +0100
Content-Disposition: inline
In-Reply-To: <2c0942db0804171235o49238b99u6cdbd3e5c8d6ebb7@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79820>

On Thu, Apr 17, 2008 at 12:35:12PM -0700, Ray Lee wrote:
> On Thu, Apr 17, 2008 at 12:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >  > Finger-pointing, in these extreme cases, gives incentive to improve
> >  > quality.  It's a positive thing.
> >
> >  Sorry, but I have to disagree.  Negative finger-pointing is never a good thing.
> 
> Correct, but let's be careful here. The original suggestion was,
> effectively, to get better metrics on the quality of contributions.

	There already is one: reputation with people working on the tree,
be it actively modifying/reviewing/bug hunting/etc.  _We_ _already_ _know_;
generally one gets a decent idea of what to expect pretty soon.

	And frankly, that's the only thing that matters anyway; I suspect
I'd do rather well by proposed criteria, but you know what?  I don't give
a flying f*ck through the rolling doughnut for self-appointed PHBs and
their idea of performance reviews.

	Think of it as a modified Turing test: convince me that you are
not a script piped through an Eng.Lit. wanker or an MBA, then I might care
for your opinion.

	Al, who never had problems with pointing fingers and laughing, but
likes an informed human brain to be the source of it...
