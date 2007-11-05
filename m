From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if
	cur/ is empty
Date: Mon, 5 Nov 2007 16:26:24 -0500
Message-ID: <20071105212624.GA9520@sigill.intra.peff.net>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9T0-0003Xb-8x
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbXKEV01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXKEV01
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:26:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4724 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbXKEV01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:26:27 -0500
Received: (qmail 25301 invoked by uid 111); 5 Nov 2007 21:26:26 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 16:26:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 16:26:24 -0500
Content-Disposition: inline
In-Reply-To: <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63558>

On Mon, Nov 05, 2007 at 12:49:20PM +0000, Gerrit Pape wrote:

> On Fri, Oct 26, 2007 at 06:01:18PM +0200, Fernando J. Pereda wrote:
> > By that reasoning, you should make it parse both cur/ and new/.
> Okay.

Isn't the subject line now wrong?

-Peff
