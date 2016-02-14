From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] git-config.txt: describe '--includes' default
 behavior
Date: Sat, 13 Feb 2016 19:34:48 -0500
Message-ID: <20160214003448.GA11268@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-2-git-send-email-larsxschneider@gmail.com>
 <20160213171704.GF30144@sigill.intra.peff.net>
 <xmqqpow0s4ux.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 01:35:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUkf7-0006Yg-Of
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 01:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbcBNAev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 19:34:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:41660 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751046AbcBNAev (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 19:34:51 -0500
Received: (qmail 30336 invoked by uid 102); 14 Feb 2016 00:34:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 19:34:50 -0500
Received: (qmail 28671 invoked by uid 107); 14 Feb 2016 00:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 19:34:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 19:34:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpow0s4ux.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286131>

On Sat, Feb 13, 2016 at 01:00:22PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I did not realize then that my patch from:
> >
> >   http://article.gmane.org/gmane.comp.version-control.git/262641
> >
> > was never picked up (but of course I've been carrying it in my tree for
> > a year).
> 
> Hmm, I do not see how it happened, either.  It is not like I was
> offline (I can see I was involved in other threads from the same
> timeframe).  Perhaps it was lost in the noise.
> 
> Thanks for following up.

>From even my limited time as acting maintainer, I know it is easy for
things to occasionally fall through the cracks for no real reason. We
rely on submitters to be invested enough in their patch series to give a
gentle prod in such cases. However, I sometimes churn out little patches
like this at such a rate that _I_ forget about them, too. :)

I do keep them in my tree, but I have so many half-finished and failed
experiments that they get lost in the noise. I should do a better job of
periodically reviewing and reposting or discarding my personal topics (I
have 65 right now!).

-Peff
