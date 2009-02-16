From: Jeff King <peff@peff.net>
Subject: Re: send-email sending shallow threads by default
Date: Sun, 15 Feb 2009 21:43:08 -0500
Message-ID: <20090216024308.GB18780@sigill.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net> <5ABF2654-851C-47F3-9D3A-3F73F13AC5DC@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Mon Feb 16 03:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtTP-0007s5-7q
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbZBPCnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbZBPCnP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:43:15 -0500
Received: from peff.net ([208.65.91.99]:60512 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbZBPCnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:43:15 -0500
Received: (qmail 12278 invoked by uid 107); 16 Feb 2009 02:43:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 15 Feb 2009 21:43:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 21:43:08 -0500
Content-Disposition: inline
In-Reply-To: <5ABF2654-851C-47F3-9D3A-3F73F13AC5DC@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110115>

On Mon, Feb 16, 2009 at 12:09:11AM +0000, Pieter de Bie wrote:

> On 16 feb 2009, at 00:07, Jeff King wrote:
>
>> Are there common readers that thread but do not order by date?
>
> Apple's Mail orders by date received, rather than date sent

Hmph. I guess it is a potential problem, then. If you use Apple Mail,
can you report on whether out of order threads have been a problem
(since earlier discussion revealed that both deep and shallow threads
are found in the wild)?

-Peff
