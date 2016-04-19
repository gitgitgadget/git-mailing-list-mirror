From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/6] Move PGP verification out of verify-tag
Date: Tue, 19 Apr 2016 01:16:12 -0400
Message-ID: <20160419051611.GC19439@sigill.intra.peff.net>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Tue Apr 19 07:16:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asO1L-0006Bo-9c
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 07:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbcDSFQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 01:16:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:51887 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751740AbcDSFQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 01:16:15 -0400
Received: (qmail 5974 invoked by uid 102); 19 Apr 2016 05:16:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 01:16:14 -0400
Received: (qmail 12958 invoked by uid 107); 19 Apr 2016 05:16:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 01:16:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 01:16:12 -0400
Content-Disposition: inline
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291844>

On Sun, Apr 17, 2016 at 06:26:55PM -0400, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> This is a follow up of [1], [2], [3], [4], and [5]. patches 1/6, 2/6 and 3/6
> are the same as the corresponding commits in pu.

Aside from the minor point I mentioned, and the ones from Eric, this
looks good to me. None of them is that big a deal, but there are enough
that it's probably worth one more re-roll to clean them all up.

Thanks for sticking with it.

-Peff
