From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] (v2) default "git merge" without argument to "git merge
 @{u}"
Date: Mon, 31 Jan 2011 17:55:29 -0500
Message-ID: <20110131225529.GC14419@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
 <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Miles Bader <miles@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:55:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2eq-00069U-An
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab1AaWzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:55:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38746 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285Ab1AaWze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:55:34 -0500
Received: (qmail 14536 invoked by uid 111); 31 Jan 2011 22:55:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Jan 2011 22:55:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 17:55:29 -0500
Content-Disposition: inline
In-Reply-To: <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165771>

On Mon, Jan 31, 2011 at 12:50:30PM -0800, Junio C Hamano wrote:

> Perhaps I should start a new directory in todo branch (say, 1.8.0), accept
> patches from people?  I'd grudgingly admit that using Wiki on k.org may be
> less burdensome (I hate editing inside the browser myself), but I'd want
> to keep the mailing list the center of discussion and am afraid that
> forcing people to go to Wiki would fragment the discussion.

I really wish we had a git-backed wiki. I also hate using the browser
for such things (though browser extensions to edit textareas in a Real
Editor at least make it tolerable, it still ends up clunky).

GitHub's wiki gets this right. I'm not saying we should host our wiki
there (well, it _would_ make setting it up pretty damn easy). But their
wiki system (gollum) is open-source, albeit in ruby. And surely there
are other git-backed alternatives (it's been a while since I've looked).

> Proposal:
> [...]

Well, I don't know this is still just an example, but your update looks
fine to me. :)

-Peff
