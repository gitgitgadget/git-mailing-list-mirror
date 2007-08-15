From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch
	-	scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 10:26:41 -0700
Message-ID: <1187198801.7443.20.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>
	 <1187143925.32555.208.camel@localhost> <46C2C9DC.9030307@s5r6.in-berlin.de>
	 <46C2E727.3050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Rene Herman <rene.herman@gmail.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934540AbXHOR1i@vger.kernel.org Wed Aug 15 19:27:50 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934540AbXHOR1i@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILMeo-0000q8-MK
	for glk-linux-kernel-3@gmane.org; Wed, 15 Aug 2007 19:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934540AbXHOR1i (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 15 Aug 2007 13:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761914AbXHOR1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Aug 2007 13:27:12 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:1731 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762608AbXHOR1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Aug 2007 13:27:09 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id KAA27856;
	Wed, 15 Aug 2007 10:48:48 -0700
In-Reply-To: <46C2E727.3050407@gmail.com>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55929>

On Wed, 2007-08-15 at 13:44 +0200, Rene Herman wrote:
> On 08/15/2007 11:39 AM, Stefan Richter wrote:
> > Note, maintainer contacts
> >   - should be available to patch submitters and
> >   - must be available to *problem reporters*
> > without having to have git and a .git repo.
> That "must" seems rather strong. But those few non-developer users that 
> could care are served by a MAINTAINERS file generated into releases.

Good idea for scripts to help kernel bug reporters.
REPORTING-BUGS is underutilized as a guide.

I think Bug reporting is a separate issue from patch CC'ing.
I'd rather have MAINTAINERS disappear altogether.
