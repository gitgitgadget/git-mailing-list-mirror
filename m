From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 22:11:40 +0300
Message-ID: <20080826191140.GA19785@mithlond.arda.local>
References: <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <20080826185548.GA7559@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Al Viro <viro@hera.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3zk-0006hj-CC
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758969AbYHZTM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758791AbYHZTM6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:12:58 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:43288 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956AbYHZTM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:12:57 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F1534013E1BE8; Tue, 26 Aug 2008 22:11:44 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KY3x6-0005GZ-Tq; Tue, 26 Aug 2008 22:11:40 +0300
Content-Disposition: inline
In-Reply-To: <20080826185548.GA7559@hera.kernel.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93802>

Al Viro wrote (2008-08-26 18:55 +0000):

> Well, to be fair, "man git-add for git add is rather unconventional" is
> a valid point...

True. I'd say that for people familiar with other VCS/SCM tools the 
"$VCS help add" is probably the primary help interface. It works with 
many tools - git, hg, svn and bzr at least.
