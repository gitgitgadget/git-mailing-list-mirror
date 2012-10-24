From: Jeff King <peff@peff.net>
Subject: A note from the (interim) maintainer
Date: Wed, 24 Oct 2012 05:01:18 -0400
Message-ID: <20121024090117.GA23819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 11:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQwqF-0000eB-I0
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 11:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933856Ab2JXJBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 05:01:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53825 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933529Ab2JXJBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 05:01:22 -0400
Received: (qmail 28068 invoked by uid 107); 24 Oct 2012 09:02:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Oct 2012 05:02:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2012 05:01:18 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208301>

Since Junio is gone for a few weeks, I'll be doing my best to fill in.
My plan is to pick up topics from the list and keep development moving
on "master" and "next". I'm not planning on cutting any releases, which
should be fine unless some emergency comes up which would require a
quick v1.8.0.1.

I'll publish my branches at:

  git://github.com/peff/git.git

There's nothing new there yet. Now that the 1.8.0 dust has settled, I'm
going to start graduating existing topics to master, according to the
comments from the latest "What's Cooking" messages. I'll also rewind
"next" soon-ish.

I've picked up a few topics from the list already, but there's some
backlog. My goal for Wednesday is to process the rest of that, push out
an integration cycle, and then send out a What's Cooking with the
current state. If you have a topic in flight with no response, I
probably just haven't looked at it yet. If you don't see it in the next
WC, though, I probably missed it and you should resend.

-Peff
