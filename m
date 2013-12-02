From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] use starts_with() and ends_with()
Date: Mon, 2 Dec 2013 10:09:56 -0500
Message-ID: <20131202150956.GA20543@sigill.intra.peff.net>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 02 16:10:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnV8M-0002Tb-K4
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 16:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab3LBPJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 10:09:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:49045 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751432Ab3LBPJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 10:09:58 -0500
Received: (qmail 21760 invoked by uid 102); 2 Dec 2013 15:09:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Dec 2013 09:09:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Dec 2013 10:09:56 -0500
Content-Disposition: inline
In-Reply-To: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238635>

On Sun, Dec 01, 2013 at 08:49:13AM +0100, Christian Couder wrote:

> This is a new patch series along the lines Junio suggested in this
> thread:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/238054/
> 
> I send it now because I saw a 1.8.5 tag.

This looks sane to me. Your 4/5 did not make it to the list (nor
directly to me), though. Perhaps because it is huge?

-Peff
