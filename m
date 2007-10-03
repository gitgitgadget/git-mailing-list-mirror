From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 3 Oct 2007 18:11:55 -0400
Message-ID: <20071003221155.GA28491@coredump.intra.peff.net>
References: <1191390255.16292.2.camel@koto.keithp.com> <7vtzp8g2s2.fsf@gitster.siamese.dyndns.org> <87y7ekr86e.wl%cworth@cworth.org> <47038669.30302@viscovery.net> <Pine.LNX.4.64.0710031634300.28395@racer.site> <87myv0qj2u.wl%cworth@cworth.org> <85ejgcrx6r.fsf@lola.goethe.zz> <20071003202157.GA28043@coredump.intra.peff.net> <Pine.LNX.4.64.0710032238080.28395@racer.site> <7vodffdg6i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Worth <cworth@cworth.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 00:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdCRr-0000L3-3x
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 00:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbXJCWL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 18:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbXJCWL6
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 18:11:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2058 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516AbXJCWL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 18:11:58 -0400
Received: (qmail 21195 invoked by uid 111); 3 Oct 2007 22:11:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Oct 2007 18:11:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2007 18:11:55 -0400
Content-Disposition: inline
In-Reply-To: <7vodffdg6i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59900>

On Wed, Oct 03, 2007 at 02:47:01PM -0700, Junio C Hamano wrote:

> AFAIK, you are wrong ;-)
> 
> {1,2,3,4,5} expands regardless of what's on the filesystem but I
> do not think it is POSIX.

Yes, I think that is right.

-Peff
