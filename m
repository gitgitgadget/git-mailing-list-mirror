From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: talk about pager in api-trace.txt
Date: Mon, 29 Feb 2016 16:31:52 -0500
Message-ID: <20160229213152.GC25342@sigill.intra.peff.net>
References: <1456755680-4335-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:32:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVQ8-0007ad-7Y
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcB2Vb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:31:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:51769 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751125AbcB2Vbz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:31:55 -0500
Received: (qmail 9532 invoked by uid 102); 29 Feb 2016 21:31:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:31:55 -0500
Received: (qmail 31298 invoked by uid 107); 29 Feb 2016 21:32:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:32:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 16:31:52 -0500
Content-Disposition: inline
In-Reply-To: <1456755680-4335-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287908>

On Mon, Feb 29, 2016 at 03:21:20PM +0100, Christian Couder wrote:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/technical/api-trace.txt | 43 +++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

I think this is fine. I'm not sure how many people would look at the
technical/api documentation in such a case, but I don't think it hurts
to document this stuff.

-Peff
