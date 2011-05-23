From: Jeff King <peff@peff.net>
Subject: Re: git issues/bugs - is there an alert process?
Date: Mon, 23 May 2011 17:21:50 -0400
Message-ID: <20110523212150.GF6281@sigill.intra.peff.net>
References: <1306172653284-6395510.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: funeeldy <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:21:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOcZa-00010i-7O
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 23:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601Ab1EWVVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 17:21:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47690
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757317Ab1EWVVw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 17:21:52 -0400
Received: (qmail 23775 invoked by uid 107); 23 May 2011 21:23:56 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 17:23:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 17:21:50 -0400
Content-Disposition: inline
In-Reply-To: <1306172653284-6395510.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174279>

On Mon, May 23, 2011 at 10:44:13AM -0700, funeeldy wrote:

> Is there any way for me to sign up to get alerts for serious bugs discovered
> in a version of git?

You can read the release notes; minor versions are always bugfix
releases, and important bugfixes are backported to them. If you read
only the [ANNOUNCE] messages on git@vger, you will see new releases.

I seem to recall we have an announce-only mailing list, and somebody set
up an rss feed, but I don't remember the details. Maybe somebody else
does, or you can find it via google.

-Peff
