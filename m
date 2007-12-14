From: Jeff King <peff@peff.net>
Subject: Re: [Funky] "git -p cmd" inside a bare repository
Date: Fri, 14 Dec 2007 00:14:34 -0500
Message-ID: <20071214051434.GE10169@sigill.intra.peff.net>
References: <20071129122139.GA11176@laptop> <7vmysexdvw.fsf@gitster.siamese.dyndns.org> <20071214051223.GD10169@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 06:15:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J32t1-0004f6-MU
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbXLNFOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 00:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXLNFOh
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:14:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3810 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbXLNFOg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 00:14:36 -0500
Received: (qmail 20136 invoked by uid 111); 14 Dec 2007 05:14:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 14 Dec 2007 00:14:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2007 00:14:34 -0500
Content-Disposition: inline
In-Reply-To: <20071214051223.GD10169@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68224>

On Fri, Dec 14, 2007 at 12:12:23AM -0500, Jeff King wrote:

> -- >8 --
> delay "git -p" page spawning until command runtime

Hrmph. Bad timing. :)

Your patch is much nicer, though, so please ignore mine.

-Peff
