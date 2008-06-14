X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT] "git ls-remote
	http://git.domain.com/repo.git?HEAD" doesn't work
Date: Sat, 14 Jun 2008 05:31:26 -0400
Message-ID: <20080614093126.GC22538@sigill.intra.peff.net>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org> <loom.20080614T074854-525@post.gmane.org> <20080614090244.GA1262@glandium.org> <loom.20080614T092039-924@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
NNTP-Posting-Date: Sat, 14 Jun 2008 09:31:44 +0000 (UTC)
Cc: git@vger.kernel.org
To: Sven <svoop@delirium.ch>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Content-Disposition: inline
In-Reply-To: <loom.20080614T092039-924@post.gmane.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1K7S7U-0001Ny-TF for gcvg-git-2@gmane.org; Sat, 14 Jun 2008
 11:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755676AbYFNJb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008
 05:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbYFNJb3
 (ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:31:29 -0400
Received: from peff.net ([208.65.91.99]:4332 "EHLO peff.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1755148AbYFNJb2
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 14 Jun 2008 05:31:28 -0400
Received: (qmail 7843 invoked by uid 111); 14 Jun 2008 09:31:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 (smtp-auth username relayok, mechanism cram-md5) by peff.net (qpsmtpd/0.32)
 with ESMTP; Sat, 14 Jun 2008 05:31:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun
 2008 05:31:26 -0400
Sender: git-owner@vger.kernel.org

On Sat, Jun 14, 2008 at 09:24:57AM +0000, Sven wrote:

> As I said, I'm lacking the skills. But I'd take part in sponsoring the
> patch so it's not another 7 weeks wait :-) I know, it's kinda unusual,
> but it's important to me that Capistrano works out of the box with Git
> over HTTP. So I'd throw in $50, anybody willing to join, too. Or to do
> the patch?

Maybe I wasn't clear in my other message. The wait is either "none,
upgrade to the current master", or "a week or so, wait for 1.5.6 to be
released."

But I'll take the $50. ;)

