From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Disclaimer about the number of slots.
Date: Wed, 4 Mar 2015 02:51:10 -0500
Message-ID: <20150304075109.GC28502@peff.net>
References: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
 <1425453571-8771-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Mar 04 08:51:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT45P-0006JC-A4
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbbCDHvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:51:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:56085 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933389AbbCDHvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:51:12 -0500
Received: (qmail 23642 invoked by uid 102); 4 Mar 2015 07:51:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 01:51:12 -0600
Received: (qmail 28098 invoked by uid 107); 4 Mar 2015 07:51:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 02:51:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 02:51:10 -0500
Content-Disposition: inline
In-Reply-To: <1425453571-8771-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264730>

On Wed, Mar 04, 2015 at 08:19:31AM +0100, Matthieu Moy wrote:

> So, sending this in case other people think it's a good idea, but I
> won't fight for it in case you don't think it is.
> [...]
> --- a/SoC-2015-Ideas.md
> +++ b/SoC-2015-Ideas.md
> @@ -20,6 +20,11 @@ Please, include link(s) to the mailing-list discussion(s) related to
>  your microproject in your application (e.g. linking to
>  [gmane](http://news.gmane.org/gmane.comp.version-control.git)).
>  
> +## Note about the number of slots
> +
> +In 2015, the Git organization has very limited mentoring capacity.
> +We will probably be able to accept 2 students only this year.

I'm on the fence. I don't mind giving a warning, but I'm not sure that
this isn't just as likely to scare off students we want. :) Maybe
something along the lines of "If you are really excited about working on
git, we would love to see your application; if you are just looking for
a random project, there may be a lot of competition for a small number
of slots". Except I am not quite sure how to phrase "just looking for a
random project" that does not sound quite so demeaning.

-Peff
