From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] git-config.txt: describe '--includes' default
 behavior
Date: Sun, 14 Feb 2016 11:05:47 -0500
Message-ID: <20160214160546.GA5875@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-2-git-send-email-larsxschneider@gmail.com>
 <20160213171704.GF30144@sigill.intra.peff.net>
 <0FE601E5-B926-4E23-9FA5-2F898C12BBB9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:06:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUzBP-0005mG-K1
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 17:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbcBNQFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 11:05:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:41818 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751775AbcBNQFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 11:05:51 -0500
Received: (qmail 12918 invoked by uid 102); 14 Feb 2016 16:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:05:51 -0500
Received: (qmail 1291 invoked by uid 107); 14 Feb 2016 16:05:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:05:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2016 11:05:47 -0500
Content-Disposition: inline
In-Reply-To: <0FE601E5-B926-4E23-9FA5-2F898C12BBB9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286154>

On Sun, Feb 14, 2016 at 01:17:43PM +0100, Lars Schneider wrote:

> Oh. Believe it or not but the similarity is coincidental. I referenced you 
> ("Helped-by") because you explained the expected "includes" behavior to
> me in your v2 review of my series. If I would have found your patch, I 
> would have said so.

Heh. Well, then we can take it as an endorsement, since we both
independently wrote almost the same thing. :)

> I am happy to use your wording. How should I proceed? Should I just drop 
> my "git-config.txt" patch from my series or should I integrate your patch 
> into my series? If the latter, then does the patch require a "Signed-off-by:"
> by me?

It looks like Junio picked up my original, so I think we can just treat
it independently of this topic.

-Peff
