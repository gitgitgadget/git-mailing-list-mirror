From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/4] Expanding tabs in "git log" output
Date: Mon, 4 Apr 2016 21:53:26 -0400
Message-ID: <20160405015326.GC29953@sigill.intra.peff.net>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:04:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anGLd-0006tx-MQ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 04:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945AbcDEBxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:53:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:44189 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756607AbcDEBxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:53:55 -0400
Received: (qmail 23365 invoked by uid 102); 5 Apr 2016 01:53:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 21:53:30 -0400
Received: (qmail 32394 invoked by uid 107); 5 Apr 2016 01:53:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 21:53:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Apr 2016 21:53:26 -0400
Content-Disposition: inline
In-Reply-To: <1459817917-32078-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290752>

On Mon, Apr 04, 2016 at 05:58:33PM -0700, Junio C Hamano wrote:

> So here is the fifth and hopefully the final try.  Previous round
> are at $gmane/289694, $gmane/289166, $gmane/288987 and
> $gmane/290222.

With the exception of two minor nits on the final patch, this looks good
to me. Thanks for cleaning up the option-parsing ordering thing; I think
it turned out rather nice.

-Peff
