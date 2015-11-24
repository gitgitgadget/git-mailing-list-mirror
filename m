From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] check-ignore: correct documentation about output
Date: Tue, 24 Nov 2015 17:13:17 -0500
Message-ID: <20151124221317.GE29185@sigill.intra.peff.net>
References: <1448051381.6899.2.camel@kaarsemaker.net>
 <20151120203045.GA16353@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Lpy-0001xY-Ei
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbbKXWNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:13:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:33485 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754307AbbKXWNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:13:20 -0500
Received: (qmail 26478 invoked by uid 102); 24 Nov 2015 22:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:13:19 -0600
Received: (qmail 19079 invoked by uid 107); 24 Nov 2015 22:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:13:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 17:13:17 -0500
Content-Disposition: inline
In-Reply-To: <20151120203045.GA16353@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281639>

On Fri, Nov 20, 2015 at 09:30:48PM +0100, Dennis Kaarsemaker wrote:

> By default git check-ignore shows only the filenames that will be
> ignored, not the pattern that causes their exclusion. Instead of moving
> the partial exclude pattern precendence information to the -v option
> where it belongs, link to gitignore(5) which describes this more
> thoroughly.
> 
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  Documentation/git-check-ignore.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks, your update looks good to me.

-Peff
