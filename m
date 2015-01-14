From: Jeff King <peff@peff.net>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 16:02:22 -0500
Message-ID: <20150114210222.GA5396@peff.net>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
 <20150114121915.GB30383@peff.net>
 <20150114123536.GA31530@peff.net>
 <xmqqvbk9b81d.fsf@gitster.dls.corp.google.com>
 <20150114205437.GB1155@peff.net>
 <CAPig+cQ9GpL9r6Rr96jc6G=EvCArodSXC-qMzSBp=e7c7QQbtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Henning Moll <newsScott@gmx.de>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBV5I-0008M3-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbbANVCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:02:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:34594 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754201AbbANVCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:02:24 -0500
Received: (qmail 14587 invoked by uid 102); 14 Jan 2015 21:02:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 15:02:24 -0600
Received: (qmail 6631 invoked by uid 107); 14 Jan 2015 21:02:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 16:02:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 16:02:22 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQ9GpL9r6Rr96jc6G=EvCArodSXC-qMzSBp=e7c7QQbtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262429>

On Wed, Jan 14, 2015 at 04:00:37PM -0500, Eric Sunshine wrote:

> > So yeah, the most plausible theory to me so far is unluckiness combined
> > with pre-1.8.4.2. That should be easy to disprove if Henning tells us
> > his git version.
> 
> Henning mentioned it at the very top of his original problem report:
> 
>     "(git version 2.2.0)"

Ah, reading comprehension. It pays off.

I'm stumped, then.

-Peff
