From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2009, #01; Tue, 03)
Date: Tue, 3 Mar 2009 04:15:04 -0500
Message-ID: <20090303091504.GG3627@coredump.intra.peff.net>
References: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:16:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQjt-00042b-Hi
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZCCJPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZCCJPJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:15:09 -0500
Received: from peff.net ([208.65.91.99]:40776 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbZCCJPI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:15:08 -0500
Received: (qmail 14328 invoked by uid 107); 3 Mar 2009 09:15:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 04:15:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 04:15:04 -0500
Content-Disposition: inline
In-Reply-To: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112039>

On Tue, Mar 03, 2009 at 01:01:45AM -0800, Junio C Hamano wrote:

> As an experiment, 'next' and 'pu' stayed open during this release freeze;
> new topics have been accepted.  I have to say that the experiment was a
> moderate success, and many topics in 'next' seem to be of fairly high
> quality already, which would mean that we will have a shorter cycle before
> 1.6.3.

I was going to stay quiet on this issue until after 1.6.3 released, but
now you have opened the topic. :)

I think seeing the quality of topics in 'next' is only half of
"success". You have to also consider how much attention was given to the
about-to-be-released version (and its impact on quality). And I think we
won't know about that until we see how quickly we need 1.6.3.1. :)

Personally, I know that I have spent much less time focusing on
'master'. Like everyone else, I have limited git bandwidth, and topics
in 'next' are simply more interesting. I think it's easier to put them
aside for a few weeks if everybody agrees to do so (rather than having
interesting discussion proceeding without you if you choose to focus on
'master').

-Peff
