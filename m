From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] init: handle empty "template" parameter, was Re: fetch
	refspec foo/* matches foo*
Date: Mon, 28 Jul 2008 02:16:00 -0400
Message-ID: <20080728061600.GA10885@sigill.intra.peff.net>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com> <20080725204051.GB23202@spearce.org> <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org> <20080726082405.GA10104@sigill.intra.peff.net> <20080726083356.GB10104@sigill.intra.peff.net> <alpine.DEB.1.00.0807261511490.26810@eeepc-johanness> <20080728060204.GC7294@sigill.intra.peff.net> <7vljzmv8mm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNM2q-0006zN-Un
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbYG1GQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbYG1GQE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:16:04 -0400
Received: from peff.net ([208.65.91.99]:3961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbYG1GQD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:16:03 -0400
Received: (qmail 29655 invoked by uid 111); 28 Jul 2008 06:16:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Jul 2008 02:16:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2008 02:16:00 -0400
Content-Disposition: inline
In-Reply-To: <7vljzmv8mm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90415>

On Sun, Jul 27, 2008 at 11:13:37PM -0700, Junio C Hamano wrote:

> Thanks, it seems that I keep forgetting to apply this patch after saying
> to myself "Heh, it obviously is the correct thing to do".

That is why you have other developers to nag you. ;)

-Peff
