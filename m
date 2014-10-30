From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bundle: split out a helper function to compute and write
 prerequisites
Date: Thu, 30 Oct 2014 17:26:42 -0400
Message-ID: <20141030212641.GB26030@peff.net>
References: <54500212.7040603@web.de>
 <20141029172109.GA32234@peff.net>
 <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
 <xmqqh9ylwhv2.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:27:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxF1-0005Ek-Tx
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934860AbaJ3V0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:26:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:35280 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933566AbaJ3V0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 17:26:44 -0400
Received: (qmail 2423 invoked by uid 102); 30 Oct 2014 21:26:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 16:26:44 -0500
Received: (qmail 9077 invoked by uid 107); 30 Oct 2014 21:26:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 17:26:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Oct 2014 17:26:42 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9ylwhv2.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 30, 2014 at 11:08:17AM -0700, Junio C Hamano wrote:

> The new helper compute_and_write_prerequistes() is ugly, but it

s/quistes/quisites/

The same typo is in the function name in the code.

-Peff
