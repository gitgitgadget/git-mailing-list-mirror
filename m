From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/5] allow more sources for config values
Date: Fri, 12 Jul 2013 06:10:53 -0400
Message-ID: <20130712101052.GA6024@sigill.intra.peff.net>
References: <20130711223614.GA26477@book-mint>
 <7vk3kwptkl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 12:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxaJa-0004a9-0u
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 12:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525Ab3GLKK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 06:10:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:38032 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111Ab3GLKK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 06:10:57 -0400
Received: (qmail 28381 invoked by uid 102); 12 Jul 2013 10:12:15 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 05:12:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 06:10:53 -0400
Content-Disposition: inline
In-Reply-To: <7vk3kwptkl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230191>

On Thu, Jul 11, 2013 at 04:26:02PM -0700, Junio C Hamano wrote:

> Thanks.
> 
> The differences since the last round I see are these.  And I think
> the series overall makes sense (I haven't look hard enough to pick
> any nits yet, though).

Both v4 and the interdiff look fine to me. I gave it one more cursory
read-through, and I don't see any problems. So:

Acked-by: Jeff King <peff@peff.net>

-Peff
