From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Bisect reset: remove bisect refs that may have been
	packed.
Date: Thu, 15 Nov 2007 03:52:59 -0500
Message-ID: <20071115085259.GA30913@sigill.intra.peff.net>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org> <7vwssj6hw8.fsf@gitster.siamese.dyndns.org> <473C02F9.4020402@viscovery.net> <20071115084934.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsaUU-0002jL-44
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252AbXKOIxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbXKOIxF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:53:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4967 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756252AbXKOIxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:53:04 -0500
Received: (qmail 7743 invoked by uid 111); 15 Nov 2007 08:53:01 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 Nov 2007 03:53:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2007 03:52:59 -0500
Content-Disposition: inline
In-Reply-To: <20071115084934.GN14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65092>

On Thu, Nov 15, 2007 at 03:49:34AM -0500, Shawn O. Pearce wrote:

> What's this obsession with whitespace in refnames?  Twice in like
> two days people are talking about whitespace in refnames.

I even had Junio convinced at one point!

I am not actually creating such refs, but I think my brain was still
fried from the URL encoding discussion, and I was overly paranoid about
spaces.

-Peff
