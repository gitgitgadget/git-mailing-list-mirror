From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] configure.ac: try -lpthread in $LIBS instead of $CFLAGS
Date: Fri, 20 Nov 2015 06:42:07 -0500
Message-ID: <20151120114207.GG11198@sigill.intra.peff.net>
References: <201511081528.tA8FSgdc003895@tezro.nonet>
 <vpqy4e8cwhr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Rainer M. Canavan" <git@canavan.de>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:42:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzk51-00046k-OB
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162181AbbKTLmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 06:42:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:60081 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161907AbbKTLmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:42:10 -0500
Received: (qmail 19867 invoked by uid 102); 20 Nov 2015 11:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:42:10 -0600
Received: (qmail 26796 invoked by uid 107); 20 Nov 2015 11:42:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:42:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:42:07 -0500
Content-Disposition: inline
In-Reply-To: <vpqy4e8cwhr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281510>

On Sun, Nov 08, 2015 at 05:00:00PM +0100, Matthieu Moy wrote:

> "Rainer M. Canavan" <git@canavan.de> writes:
> 
> >  configure.ac | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Looks all right to me. Thanks for you contribution and for your
> patience!

Thanks, both. I've queued this to eventually hit "maint".

-Peff
