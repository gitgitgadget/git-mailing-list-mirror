From: Jeff King <peff@peff.net>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Thu, 23 Jul 2015 10:35:43 -0700
Message-ID: <20150723173542.GA18686@peff.net>
References: <20150723012343.GA21000@peff.net>
 <20150723044007.GA3651@gmail.com>
 <20150723051445.GA24029@peff.net>
 <20150723054816.GA1917@peff.net>
 <CA+P7+xrNiK168rXX3SwwmQFPR6i4iA0nhFdfHKL7wqwtwvnEPA@mail.gmail.com>
 <20150723065310.GA7542@peff.net>
 <CA+P7+xrX5q_abQYZ-LkzAjvEKmZ+-ykJBS-DwOaLJ6d62-CHPw@mail.gmail.com>
 <55B0B9A1.7060609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKPP-0005n9-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbbGWRfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:35:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:34166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753650AbbGWRfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:35:47 -0400
Received: (qmail 19404 invoked by uid 102); 23 Jul 2015 17:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 12:35:46 -0500
Received: (qmail 13608 invoked by uid 107); 23 Jul 2015 17:35:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 13:35:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2015 10:35:43 -0700
Content-Disposition: inline
In-Reply-To: <55B0B9A1.7060609@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274512>

On Thu, Jul 23, 2015 at 11:53:37AM +0200, Michael J Gruber wrote:

> That reminds me of my attempt to add those "categories" to the man pages
> of each command (rather than just to that of "git") so that users know
> where they landed. It died off, though: I preferred just specifying the
> category (maybe with a long form), others including the whole
> explanation of the category (which I thought would be too much text; we
> have the glossary for that).
> 
> Would something like that help? Maybe "category" plus optionally pointer
> to a related command in the "other" category.

Maybe a "SCRIPTING" section at the end of the page?

-Peff
