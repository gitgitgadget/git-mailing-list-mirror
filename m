From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Clarify how content states are to be built as the
 fast-import stream is interpreted.
Date: Thu, 8 Nov 2012 12:43:00 -0500
Message-ID: <20121108174300.GI15560@sigill.intra.peff.net>
References: <20121105043101.GA24687@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 18:43:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWW8N-0002lG-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 18:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab2KHRnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 12:43:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36509 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390Ab2KHRnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 12:43:04 -0500
Received: (qmail 31277 invoked by uid 107); 8 Nov 2012 17:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 12:43:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 12:43:00 -0500
Content-Disposition: inline
In-Reply-To: <20121105043101.GA24687@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209177>

On Sun, Nov 04, 2012 at 11:31:01PM -0500, Eric S. Raymond wrote:

> 
> ---
>  Documentation/git-fast-import.txt |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Looks reasonable. Sign-off?

-Peff
