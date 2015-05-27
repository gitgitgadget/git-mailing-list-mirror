From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 00/11] Protocol version 2, again!
Date: Wed, 27 May 2015 03:08:38 -0400
Message-ID: <20150527070838.GA6873@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <20150527061818.GA885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVSJ-0002Rn-Sl
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 09:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbbE0HIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 03:08:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:36516 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752230AbbE0HIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 03:08:41 -0400
Received: (qmail 641 invoked by uid 102); 27 May 2015 07:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:08:41 -0500
Received: (qmail 5146 invoked by uid 107); 27 May 2015 07:08:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 03:08:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 03:08:38 -0400
Content-Disposition: inline
In-Reply-To: <20150527061818.GA885@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270031>

On Wed, May 27, 2015 at 02:18:18AM -0400, Jeff King wrote:

> > The new protocol works just like the old protocol, except for
> > the capabilities negotiation being before any exchange of real data.
> 
> I like this approach. [...]

So now I've read through all the patches. I still like it. :)

There's a lot of work to be done still, but I think this is a great
start. Thanks for getting the ball rolling.

-Peff
