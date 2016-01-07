From: Jeff King <peff@peff.net>
Subject: Re: Picking up old threads/patches
Date: Thu, 7 Jan 2016 03:03:50 -0500
Message-ID: <20160107080350.GA15453@sigill.intra.peff.net>
References: <1718717.tR0GOgDc0N@thunderbird>
 <2143067.ZpDECoHz1r@thunderbird>
 <3039057.pHpnyVLACL@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Stephen & Linda Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 09:04:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH5Y7-0000WF-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 09:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbcAGID4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 03:03:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:49772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751905AbcAGIDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 03:03:55 -0500
Received: (qmail 23700 invoked by uid 102); 7 Jan 2016 08:03:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jan 2016 03:03:55 -0500
Received: (qmail 1960 invoked by uid 107); 7 Jan 2016 08:04:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jan 2016 03:04:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jan 2016 03:03:50 -0500
Content-Disposition: inline
In-Reply-To: <3039057.pHpnyVLACL@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283470>

On Wed, Jan 06, 2016 at 08:59:52PM -0700, Stephen & Linda Smith wrote:

> > If Will isn't interested in finishing these two patches I will pick them 
> > up [ ($gmane/271213), ($gmane/272180) ]
> > 
> > After that I will check look at some of the others for which you've 
> > asked for help.
>  
> I started work on both of these rerolls this evening.   Since I do not have the 
> original emails I don't have the Message ID's which  would allow me 
> to add to the threads with the git send-email command.   Do either of you have the 
> message ID's?

If it's an ancient thread, it's not a big deal to just start a new
thread (especially if you reference the old one in the text so people
can dig it up if they really care).

But for reference, you can add `/raw` to the end of a gmane article URL
to get all the headers. E.g.:

  $ gmane=http://article.gmane.org/gmane.comp.version-control.git
  $ curl -s $gmane/271213/raw | grep -i ^message-id:
  Message-ID: <CAAKF_ub5c+2vVmG161O6gnUUeEcNfDUMU=mtn+k0T8bC-9ZHPw@mail.gmail.com>

-Peff
