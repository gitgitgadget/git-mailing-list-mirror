From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 15:50:19 -0400
Message-ID: <20080827195019.GA9962@sigill.intra.peff.net>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Andi Kleen <andi@firstfloor.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYR3A-00044O-Uz
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbYH0TuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbYH0TuX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:50:23 -0400
Received: from peff.net ([208.65.91.99]:2035 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbYH0TuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:50:22 -0400
Received: (qmail 15709 invoked by uid 111); 27 Aug 2008 19:50:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 27 Aug 2008 15:50:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 15:50:19 -0400
Content-Disposition: inline
In-Reply-To: <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93934>

On Wed, Aug 27, 2008 at 12:43:23PM -0700, Perry Wagle wrote:

> Doing git-<tab> was shocking to me at first, but it also showed me a list 
> of commands for me to learn.
>
> Now I guess that when everything's fixed up, I'll have to put in a space 
> instead of a dash to get exactly the same thing.
>
> What difference did changing the dash to a space make?

Did you miss the part of the thread about how it's not exactly the same
thing, but rather substantially fewer commands (and there is even
additional discussion about _which_ commands)?

-Peff
