From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Thu, 29 May 2014 14:53:11 -0400
Message-ID: <20140529185311.GB10865@sigill.intra.peff.net>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
 <53866e8562b7a_12a7a052f87a@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 20:53:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq5S1-0004XX-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 20:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbaE2SxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 14:53:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:33613 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750940AbaE2SxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 14:53:13 -0400
Received: (qmail 14200 invoked by uid 102); 29 May 2014 18:53:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 13:53:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 14:53:11 -0400
Content-Disposition: inline
In-Reply-To: <53866e8562b7a_12a7a052f87a@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250398>

On Wed, May 28, 2014 at 06:17:25PM -0500, Felipe Contreras wrote:

> This is the last mail I sent to you, because you ignore them anyway, and
> remove them from the mailing list.
> [...]
> [2], a mail you conveniently removed from the tracked record.
> [...]
> You also conveniently removed this mail from the archives.

I see you already noticed the changes in v2.0, but I wanted to address
these points, because I consider silent censorship to be a serious
accusation.

I do not think Junio or anyone else has the technical ability to remove
messages from the archive. There is not one archive, but rather several
that get messages straight from vger.kernel.org and keep their own
database (e.g., gmane, marc, spinics, nabble). E.g., here is the
"deleted" message on nabble:

  http://git.661346.n2.nabble.com/PATCH-remote-helpers-point-at-their-upstream-repositories-td7610799i20.html#a7611324

Here it is on gmane:

  http://permalink.gmane.org/gmane.comp.version-control.git/249741

However, I had to pull that link from the NNTP interface. If you look at
the non-threaded web interface for gmane here:

  http://blog.gmane.org/gmane.comp.version-control.git/day=20140520

and here:

  http://blog.gmane.org/gmane.comp.version-control.git/day=20140521

you will see that there is a huge gap in the list coverage from about
midnight on the 20th until the 24th (but these messages are available
via nntp). So this seems much more like a gmane bug than anything else.

I've reported the bug to gmane.discuss (no link yet, as I'm waiting for
the message to go through, but it is not a high traffic group, so it
should be easy to find the thread once it is there).

-Peff
