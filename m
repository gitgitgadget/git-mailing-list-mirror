From: Jeff King <peff@peff.net>
Subject: Re: Unused #include statements
Date: Thu, 15 Jan 2015 19:00:36 -0500
Message-ID: <20150116000035.GC25120@peff.net>
References: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
 <CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
 <20150115063307.GA11028@peff.net>
 <xmqqvbk77u9m.fsf@gitster.dls.corp.google.com>
 <20150115223836.GC19021@peff.net>
 <xmqqy4p34onq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert Schiele <rschiele@gmail.com>,
	Zoltan Klinger <zoltan.klinger@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 01:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuLD-0004rW-6d
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 01:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbbAPAAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 19:00:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:35314 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753945AbbAPAAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 19:00:38 -0500
Received: (qmail 9427 invoked by uid 102); 16 Jan 2015 00:00:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 18:00:38 -0600
Received: (qmail 18564 invoked by uid 107); 16 Jan 2015 00:01:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 19:01:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 19:00:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy4p34onq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262528>

On Thu, Jan 15, 2015 at 03:20:09PM -0800, Junio C Hamano wrote:

> OK, thanks.  Let's queue something like this for post 2.3 cycle,
> then.
> 
> -- >8 --
> Subject: CodingGuidelines: clarify C #include rules
> [...]

Thanks, this looks good to me.

-Peff
