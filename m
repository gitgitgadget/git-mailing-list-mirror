From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 11:53:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161150500.10279@pacific.mpi-cbg.de>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm> <20090216040529.GC12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152113380.14911@asgard.lang.hm> <20090216043708.GB12986@coredump.intra.peff.net> <alpine.DEB.1.10.0902152143430.14911@asgard.lang.hm>
 <20090216050608.GA13181@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ17E-0001ye-GK
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbZBPKwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbZBPKwx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:52:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:44298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751170AbZBPKww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:52:52 -0500
Received: (qmail invoked by alias); 16 Feb 2009 10:52:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 16 Feb 2009 11:52:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qr2RDFAhqrxLugWZCEymCNVHWf2+wk3R+r0uXcW
	nUSnmlyE1D5eg7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090216050608.GA13181@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110166>

Hi,

On Mon, 16 Feb 2009, Jeff King wrote:

> On Sun, Feb 15, 2009 at 09:55:24PM -0800, david@lang.hm wrote:
> 
> > two cycles of changes, not three, so 6-10 years for changes that break 
> > existing bahavior without a _really_ pressing reason. so new 
> > functions, new commands, new flags don't have to wait at all. it's 
> > only if you want to change something that will cause grief for users 
> > if they get a new version and run their existing tools against it.
> 
> I think you have to think about _how much_ grief it will cause, too.

Exactly.

BTW I already get angry questions by Git users why this bug -- as they 
think about it -- is not fixed in the next Git release, and I patiently 
explain that a lot of existing users would get hurt by that change.

And on this list I get flak when pushing for Git users' needs (who will 
never be subscribed to the Git list because of the sheer volume).

I guess if both camps would just start to think a little bit about the 
other camp's needs, everybody would get a little calmer.

Ciao,
Dscho
