From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t6006: clean up whitespace
Date: Mon, 17 Dec 2012 17:59:58 -0500
Message-ID: <20121217225958.GA1809@sigill.intra.peff.net>
References: <20121217225516.GA1408@sigill.intra.peff.net>
 <20121217225552.GA1653@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkjfZ-0007ho-5L
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 00:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab2LQXAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 18:00:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57113 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab2LQXAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 18:00:00 -0500
Received: (qmail 11021 invoked by uid 107); 17 Dec 2012 23:01:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 18:01:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 17:59:58 -0500
Content-Disposition: inline
In-Reply-To: <20121217225552.GA1653@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211717>

On Mon, Dec 17, 2012 at 05:55:52PM -0500, Junio C Hamano wrote:

> From: Junio C Hamano <gitster@pobox.com>
> To: Junio C Hamano <gitster@pobox.com>
>
> The test_format function did not indent its in-line test
> script in an attempt to make the output of the test look
> better. But it does not make a big difference to the output,
> and the source looks quite ugly. Let's use our normal
> indenting instead.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Argh. This is me accidentally impersonating Junio because my home-grown
send-email replacement does not grok patches by other authors properly.
Sorry for the noise; I've just resent with a proper header.

I should probably fix my script before I embarrass myself again with
it...

-Peff
