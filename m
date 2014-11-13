From: Jeff King <peff@peff.net>
Subject: Re: t9902-completion.sh failed
Date: Thu, 13 Nov 2014 08:55:30 -0500
Message-ID: <20141113135529.GA31509@peff.net>
References: <87mw7v9xhl.fsf@gmail.com>
 <20141113112447.GA4437@peff.net>
 <878ujfxrgo.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 14:55:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xous5-0002Ze-HT
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 14:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbaKMNzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 08:55:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:39903 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932910AbaKMNzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 08:55:33 -0500
Received: (qmail 29847 invoked by uid 102); 13 Nov 2014 13:55:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 07:55:32 -0600
Received: (qmail 25706 invoked by uid 107); 13 Nov 2014 13:55:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 08:55:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 08:55:30 -0500
Content-Disposition: inline
In-Reply-To: <878ujfxrgo.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 05:34:50PM +0600, Alex Kuleshov wrote:

> I'm using ubuntu 14.04 x86_64 and bash GNU bash, version
> 4.3.11(1)-release (x86_64-pc-linux-gnu).
> 
> I didn't applied any patches to bash for all time since i installed
> system. so it reall weird

I tried on a fresh install of Ubuntu 14.04.1, with the same version of
bash, and I still can't reproduce the problem. I'm not sure what else to
check.

-Peff
