From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some
 options"
Date: Mon, 29 Feb 2016 06:12:18 -0500
Message-ID: <20160229111218.GB29769@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
 <20160226232957.GB9552@sigill.intra.peff.net>
 <CAPig+cSXY0XE7C71EAO8MOpzrtSFOA0fcxu5wxAZ-J9RzjusPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 12:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaLko-0008Kk-N6
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 12:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbcB2LMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 06:12:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:51311 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753854AbcB2LMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 06:12:21 -0500
Received: (qmail 13676 invoked by uid 102); 29 Feb 2016 11:12:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:12:21 -0500
Received: (qmail 24871 invoked by uid 107); 29 Feb 2016 11:12:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:12:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 06:12:18 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSXY0XE7C71EAO8MOpzrtSFOA0fcxu5wxAZ-J9RzjusPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287825>

On Sat, Feb 27, 2016 at 07:53:02PM -0500, Eric Sunshine wrote:

> > then it must receive the two lines of output in the correct
> 
> s/correct/& order/

I fixed this and all of the other typos by switching to a patch that
needs about one tenth as much explanation. :)

I'm sure it's not possible that I introduced any new ones...

-Peff
