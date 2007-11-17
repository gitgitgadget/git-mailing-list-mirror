From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 17 Nov 2007 07:40:05 -0500
Message-ID: <20071117124003.GA23028@sigill.intra.peff.net>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 13:40:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItMyO-000841-Fn
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 13:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbXKQMkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 07:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbXKQMkL
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 07:40:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4957 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbXKQMkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 07:40:09 -0500
Received: (qmail 3714 invoked by uid 111); 17 Nov 2007 12:40:07 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 07:40:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 07:40:05 -0500
Content-Disposition: inline
In-Reply-To: <7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65270>

On Wed, Nov 14, 2007 at 04:18:25PM -0800, Junio C Hamano wrote:

> * jk/send-pack (Tue Nov 13 06:37:10 2007 -0500) 24 commits
> [...]
> This three-patch series is built on top of four other topics and
> is meant to fix issues in built-in send-pack.  I dropped
> individial topics from Alex, Daniel, Andy and another from Jeff
> that this series depends on.  IOW, they all will graduate to
> "master" at the same time when this series proves to be stable.

Thank you, it was getting confusing with so many people working in the
same area. :)

> Will wait for a few days to hear opinions from the list, and
> then merge to "next" and start cooking.

I am about to send out an improved patch set that incorporates some of
the test fixes from Alex, some new tests from me, and a few code
cleanups.

-Peff
