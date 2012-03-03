From: Jeff King <peff@peff.net>
Subject: Re: [git wiki PATCH] "Modernizing and expanding Git.pm" project
Date: Sat, 3 Mar 2012 17:23:47 -0500
Message-ID: <20120303222347.GA29839@sigill.intra.peff.net>
References: <20120302091114.GA3984@sigill.intra.peff.net>
 <1330809281-25774-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:23:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3xMo-0003vX-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 23:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab2CCWXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 17:23:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36220
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab2CCWXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 17:23:49 -0500
Received: (qmail 10284 invoked by uid 107); 3 Mar 2012 22:23:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 03 Mar 2012 17:23:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2012 17:23:47 -0500
Content-Disposition: inline
In-Reply-To: <1330809281-25774-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192141>

On Sat, Mar 03, 2012 at 10:14:41PM +0100, Jakub Narebski wrote:

> ---
> I'm not sure if my Markdown is entirely correct.
> 
>  SoC-2012-Ideas.md |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)

Thanks, applied. Your markdown looks fine, though I dropped the quoted
heading line here:

> +> WARNING
> +> -------

As it was difficult to tell that that large text was part of a quoted
bit (probably there is some quoting mode that does not expand such
things, but I didn't think it was worth fiddling with too much).

-Peff
