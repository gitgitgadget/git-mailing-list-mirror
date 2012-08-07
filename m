From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Android Replies to Git List getting rejected
Date: Tue, 7 Aug 2012 16:55:24 -0400
Message-ID: <20120807205524.GA3953@thunk.org>
References: <CAM9Z-nmEDTEN0Em-nY+y5g0kRMsNuy-pn8Lzr_mWSU7engj6JQ@mail.gmail.com>
 <50216D83.6080707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <n1xim.email@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: John 'Warthog9' Hawley <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 22:55:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyqoX-0000pR-M9
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 22:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab2HGUze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 16:55:34 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:43494 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab2HGUzd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 16:55:33 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SyqoG-0004lQ-3Z; Tue, 07 Aug 2012 20:55:24 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 446BB2411B5; Tue,  7 Aug 2012 16:55:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <50216D83.6080707@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203046>

On Tue, Aug 07, 2012 at 01:33:23PM -0600, John 'Warthog9' Hawley wrote:
> It's pretty simple: you sent HTML mail to vger.kernel.org, and it
> explicitly rejects all HTML e-mail.  GMail, particularly from Android,
> apparently doesn't have a way to bypass sending HTML mail (it's been a
> much maligned bug).

Yeah, sigh.  Drew, I suggest that you star the following bug:

http://code.google.com/p/android/issues/detail?id=8712

... and perhaps leave a comment in the bug report that you can't
interact with the git mailing list because of this limitation.

I'm sure you know (since you indicated that you sent your e-mail via
the web interface of Gmail), that this is at least something you can
control in the desktop/web version of Gmail (just enable "Plain text"
mode) --- but it would certainly be nice if users had the choice of
whether they wanted to participate on vger mailing lists using the
Android application, versus the Web interface, or using Mutt or Pine
on a Linux box.

Regards,

					- Ted
