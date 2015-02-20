From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Documentation/config.txt: document mailinfo.scissor
Date: Fri, 20 Feb 2015 05:17:24 -0500
Message-ID: <20150220101723.GA29980@peff.net>
References: <1424426947-26441-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkeL-0004qw-Ab
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbbBTKR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:17:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:51475 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754228AbbBTKR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:17:27 -0500
Received: (qmail 16213 invoked by uid 102); 20 Feb 2015 10:17:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 04:17:27 -0600
Received: (qmail 8911 invoked by uid 107); 20 Feb 2015 10:17:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Feb 2015 05:17:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2015 05:17:24 -0500
Content-Disposition: inline
In-Reply-To: <1424426947-26441-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264148>

On Fri, Feb 20, 2015 at 11:09:06AM +0100, Matthieu Moy wrote:

> The variale was documented in git-mailinfo.txt, but not in config.txt.

Missing 'b' in variable.

> +mailinfo.scissor::

s/scissor/&s/

-Peff
