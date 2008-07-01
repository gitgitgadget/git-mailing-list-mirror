From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 1 Jul 2008 06:11:14 -0400
Message-ID: <20080701101114.GA6379@sigill.intra.peff.net>
References: <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 01 12:13:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcqx-00038H-Te
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 12:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbYGAKLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 06:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbYGAKLS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 06:11:18 -0400
Received: from peff.net ([208.65.91.99]:4562 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703AbYGAKLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 06:11:16 -0400
Received: (qmail 17640 invoked by uid 111); 1 Jul 2008 10:11:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 01 Jul 2008 06:11:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2008 06:11:14 -0400
Content-Disposition: inline
In-Reply-To: <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87021>

On Mon, Jun 30, 2008 at 02:08:56AM -0700, Junio C Hamano wrote:

> * js/apply-recount (Fri Jun 27 18:43:09 2008 +0100) 1 commit
>  + Allow git-apply to recount the lines in a hunk (AKA recountdiff)
> 
> A good ingredient for implementing "apply --edit".

Thomas,

Now that this is in next, maybe it is a good time to repost the
add--interactive patch (it should be independent of Dscho's 2/2 "add -e"
patch).

-Peff
