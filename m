From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 23:08:57 +0200
Message-ID: <20080826210857.GA29208@isilmar.linta.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5nl-0002yS-2m
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbYHZVJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 17:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYHZVJB
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:09:01 -0400
Received: from isilmar.linta.de ([213.133.102.198]:47734 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751593AbYHZVJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 17:09:00 -0400
Received: (qmail 20106 invoked by uid 1000); 26 Aug 2008 21:08:57 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93823>

Linus,

On Tue, Aug 26, 2008 at 11:19:28AM -0700, Linus Torvalds wrote:
> 	PATH="$PATH:$(git --exec-path)"
> 
> Really. I repeat that mantra over and over, exactly because it makes all 
> the whining so _pointless_.

It does indeed make it pointless, as long this PATH thing is staying.
However, some of the arguments (finally!) mentioned in this thread make me
worrying otherwise, for they become moot if this PATH thing stays. Also,

> NO, IT IS NOT DEPRECATED.

this is the first time -- despite repeated questions -- that the deprecation
notice got deprecated.

> Can't you understand that people can change plans based on feedback?

Indeed I can understand it. If people tell about it.

Best,
	Dominik
