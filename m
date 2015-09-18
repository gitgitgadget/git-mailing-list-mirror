From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Documentation: use 'keyid' consistantly, not 'key-id'
Date: Fri, 18 Sep 2015 15:23:45 -0400
Message-ID: <20150918192345.GD11068@sigill.intra.peff.net>
References: <20150917174306.GA29171@sigill.intra.peff.net>
 <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
 <1442588510-7379-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Alastair McGowan-Douglas <altreus@altre.us>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:23:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd1GC-0002mO-SV
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbbIRTXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 15:23:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:33322 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753112AbbIRTXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 15:23:48 -0400
Received: (qmail 19904 invoked by uid 102); 18 Sep 2015 19:23:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 14:23:47 -0500
Received: (qmail 10939 invoked by uid 107); 18 Sep 2015 19:23:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 15:23:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Sep 2015 15:23:45 -0400
Content-Disposition: inline
In-Reply-To: <1442588510-7379-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278218>

On Fri, Sep 18, 2015 at 05:01:48PM +0200, Matthieu Moy wrote:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/git-cherry-pick.txt | 4 ++--
>  Documentation/git-revert.txt      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Hmm, grepping for `key-id` turns up quite a few more hits. Is there any
reason not to change those, too?

-Peff
