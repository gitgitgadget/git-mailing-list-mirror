From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 10:57:19 -0400
Message-ID: <20080826145719.GB5046@coredump.intra.peff.net>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 16:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY002-0003ed-Ov
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 16:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbYHZO5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYHZO5W
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 10:57:22 -0400
Received: from peff.net ([208.65.91.99]:2062 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbYHZO5V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 10:57:21 -0400
Received: (qmail 30709 invoked by uid 111); 26 Aug 2008 14:57:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 10:57:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 10:57:19 -0400
Content-Disposition: inline
In-Reply-To: <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93749>

On Mon, Aug 25, 2008 at 04:41:57PM -0700, Junio C Hamano wrote:

> > Umm.  What exactly makes you feel you should ignore the discussions we had 
> > around the issues on the git and msysgit mailing list?
> 
> Well, this was partly my fault, as I did not make it clear in this part
> that beating the horse that has been dead for two years is not a
> productive way to spend out time.  I however did, in the part David did
> not quote, try to make it clear:
> 
>   That's all history now anyway.  We should try to do better the next time,
>   which is much more important, and that is the topic of this message.

I don't want to stir up this discussion too much; I am sure you have
many more important things to be working on. But I did want to make one
observation.

One side of the argument, I see a lot of "I would prefer it this way."
And on the other side I see a lot of "this discussion is already
history" and "but I do not care personally that much."

It makes me wonder why nobody has said "no, really, I prefer it without
the programs in /bin." Are they simply confident that the decision has
been made, and don't feel the need to say something?

I am just concerned that we are following a path that is not the best
one because "it was decided" already, when perhaps:

  - the reasons for making that decision may have changed

  - the people interested in opposing that decision didn't speak up at
    the time, either because they weren't git users then, weren't as
    active in the mailing list, changed their minds, or were simply too
    lazy to read the release notes

Again, I don't want to waste time (especially yours, Junio) with a
discussion that is fruitless. But I also don't like to see "no, you are
not allowed to bring fresh arguments to this decision". That precludes
the possibility that the decision was wrong.

Maybe the people who want to keep git-* can discuss amongst themselves
(on the list, but the rest of us can ignore it) and present a concise
argument why circumstances around this decision may have changed.

-Peff
