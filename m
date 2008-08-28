From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 14:30:41 -0600
Message-ID: <20080828203040.GQ18340@parisc-linux.org>
References: <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu> <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com> <20080827230903.GB11005@flint.arm.linux.org.uk> <48B5E90E.3000601@s5r6.in-berlin.de> <20080828191956.GA7906@flint.arm.linux.org.uk> <7v63pkew9l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	Kristian H??gsberg <krh@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:32:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYo9v-0003Of-TW
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbYH1Uay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756744AbYH1Uay
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:30:54 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:52699 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547AbYH1Uax (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:30:53 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id 90F8F494005; Thu, 28 Aug 2008 14:30:41 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <7v63pkew9l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94134>

On Thu, Aug 28, 2008 at 01:10:14PM -0700, Junio C Hamano wrote:
> I think it is fair to say that I have vetoed and am still vetoing many "UI
> clean-ups" that propose to change things in a way that "should have been
> this way for consistency's sake from day one, if there were no existing
> user base".  During discussions to shoot down such proposals, I take
> opinions from early adopters (that's you, kernel, wine and x.org people)
> very seriously, perhaps to the point that outsiders would feel I am giving
> them disproportionately large vetoing power.  Sadly, those "opinions from
> eraly adopters" are less and less "real" but more "I'd imagine the early
> adopters would say..." these days.  The process would work better if early
> adopters do their part to help me by speaking up when it matters from time
> to time.

I think it's fairly clear by now that we aren't shy about sharing our
opinions ... if we're asked for them.  So do we need a git-oldtimers
mailing list where you can post proposals so we can NACK them?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
