From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Thu, 29 May 2014 15:45:17 -0400
Message-ID: <20140529194517.GA16699@sigill.intra.peff.net>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
 <53866e8562b7a_12a7a052f87a@nysa.notmuch>
 <20140529185311.GB10865@sigill.intra.peff.net>
 <87tx88fkyt.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 29 21:45:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq6GX-0000kA-5m
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 21:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbaE2TpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 15:45:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:33656 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932326AbaE2TpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 15:45:19 -0400
Received: (qmail 17547 invoked by uid 102); 29 May 2014 19:45:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 14:45:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 15:45:17 -0400
Content-Disposition: inline
In-Reply-To: <87tx88fkyt.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250404>

On Thu, May 29, 2014 at 09:23:06PM +0200, David Kastrup wrote:

> > I do not think Junio or anyone else has the technical ability to remove
> > messages from the archive.
> 
> You can post self-destructing messages by adding X-no-archive: yes if I
> am not mistaken.  But that only concerns stuff you post yourself.

Right, I was thinking specifically of deleting somebody else's message.
The other obvious choke point is to convince vger to silently drop
messages from somebody, but:

  1. That is different than deleting already-posted messages.

  2. vger is maintained by kernel.org folks, none of whom is a
     regular on the git list. So it would involve some collusion with
     those admins.

That is pretty clearly not what happened here (the messages did go out
to the list).

> Frankly, I find it weird that vger.kernel.org does not have an archive
> of its own.

I don't think there is much need, as gmane is pretty featureful (and if
you disagree, there are other competitors, or you can set up your own).
I assume the current situation grew organically (somebody wanted an
archive, so they set it up, and then vger saw no need to compete).

-Peff

PS My gmane bug report posted here:

     http://article.gmane.org/gmane.discuss/16175
