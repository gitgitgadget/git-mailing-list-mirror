From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0008: 4 tests fail with ksh88
Date: Sat, 21 May 2016 19:07:58 -0500
Message-ID: <20160522000756.GA9591@sigill.intra.peff.net>
References: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
 <xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 02:09:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4GxS-0001q7-S8
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 02:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbcEVAIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 20:08:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:42582 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751860AbcEVAID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 20:08:03 -0400
Received: (qmail 17618 invoked by uid 102); 22 May 2016 00:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 May 2016 20:08:02 -0400
Received: (qmail 15448 invoked by uid 107); 22 May 2016 00:08:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 May 2016 20:08:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 May 2016 19:07:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295253>

On Fri, May 20, 2016 at 08:16:43AM -0700, Junio C Hamano wrote:

> > Acked-by: Jeff King <peff@peff.net>
> 
> I didn't see him acking this exact version, so if you didn't include
> this line here, I would have missed it.  Thanks.

I don't think I ever saw an actual patch to ack until now; I just said
the idea seemed good.

That being said, the patch _does_ look good, and I am fine to have my
ack/reviewed-by on it (though I agree with your points regarding the
commit message).

-Peff
