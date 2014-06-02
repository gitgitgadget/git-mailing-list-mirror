From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Mon, 2 Jun 2014 02:36:07 -0400
Message-ID: <20140602063607.GA27445@sigill.intra.peff.net>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
 <53866e8562b7a_12a7a052f87a@nysa.notmuch>
 <20140529185311.GB10865@sigill.intra.peff.net>
 <5388fb283edaf_bd8167d3002b@nysa.notmuch>
 <87k392e0mf.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:36:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrLqw-0005CH-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 08:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbaFBGgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 02:36:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:35719 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751645AbaFBGgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 02:36:09 -0400
Received: (qmail 31585 invoked by uid 102); 2 Jun 2014 06:36:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 01:36:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 02:36:07 -0400
Content-Disposition: inline
In-Reply-To: <87k392e0mf.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250554>

On Sat, May 31, 2014 at 11:52:24AM +0200, David Kastrup wrote:

> Some mailing list filters and/or spam filters flag mails with too many
> recipients so that they need to pass through moderation first.  The
> typical threads on this list are short and have few recipients while
> longer threads, due to the list policy of adding every participants to
> the Cc, will tend to have more recipients.

AFAIK, vger does not do anything like this. They block HTML, messages
lacking a message-id, messages over 100K, and certain taboo phrases:

  http://vger.kernel.org/majordomo-info.html#taboo

And anyway, I do not think vger is responsible here. The messages were
delivered through the list, and other archives have them. This looks
like a gmane problem.

According to gmane.org, their admins will look manually at messages
flagged as spam, but I find it unlikely that they flagged several days
worth of git traffic (and when they do, I think they cross-post them to
a spam group in NNTP, and the messages do not seem to be marked as
such). So I think this really is just a bug.

> And frankly, if I were a list moderator and software asked me through
> this sort of coincidence whether a mail should be delivered or not and a
> glance at it shows nothing but insults, wild accusations, threats and so
> on for the umpteenth time, I'd consider twice clicking "Accept".
> Whether or not I ultimately did so, this would likely contribute to the
> delay.

I do not disagree, but please let's not rehash all of that again.

-Peff
