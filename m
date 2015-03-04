From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Ask students to include a link to their microproject
 in their application
Date: Wed, 4 Mar 2015 02:48:10 -0500
Message-ID: <20150304074810.GB28502@peff.net>
References: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Mar 04 08:48:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT42V-0004Tp-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294AbbCDHsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:48:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:56079 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932333AbbCDHsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:48:13 -0500
Received: (qmail 23501 invoked by uid 102); 4 Mar 2015 07:48:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 01:48:13 -0600
Received: (qmail 28061 invoked by uid 107); 4 Mar 2015 07:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 02:48:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 02:48:10 -0500
Content-Disposition: inline
In-Reply-To: <1425453571-8771-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264728>

On Wed, Mar 04, 2015 at 08:19:30AM +0100, Matthieu Moy wrote:

> --- a/SoC-2015-Ideas.md
> +++ b/SoC-2015-Ideas.md
> @@ -16,6 +16,10 @@ way for us to get experience with applicants, but it will also help
>  applicants become familiar with Git's development and submission
>  process.
>  
> +Please, include link(s) to the mailing-list discussion(s) related to
> +your microproject in your application (e.g. linking to
> +[gmane](http://news.gmane.org/gmane.comp.version-control.git)).

Yeah, this is a good idea.

In fact, we can provide an application template to students via the
Melange system. I don't recall doing so in the past few years, but we
did use this feature at one point:

  https://git.wiki.kernel.org/index.php/SoC2007Template

However, I don't recall it leading to especially better-quality
applications (in fact, it may have made things worse because many
students filled it out in a very perfunctory way and then assumed that
was enough).

-Peff
