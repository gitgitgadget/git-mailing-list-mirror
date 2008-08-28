From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 17:24:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808281723580.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
 <20080826185548.GA7559@hera.kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Al Viro <viro@hera.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjIn-0000Wi-HI
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbYH1PTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbYH1PTh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:19:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:54834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752301AbYH1PTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:19:36 -0400
Received: (qmail invoked by alias); 28 Aug 2008 15:19:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 28 Aug 2008 17:19:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j3IdV0nojhKjtavhgVtB3IFp04CPmfHWGJ0z/BO
	lmwmfOLhzUgf1t
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080826185548.GA7559@hera.kernel.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94069>

Hi,

On Tue, 26 Aug 2008, Al Viro wrote:

> Well, to be fair, "man git-add for git add is rather unconventional" is 
> a valid point...

If you're prepared for even more whining, you could send a patch that 
inlines all git commands into Documentation/git.txt...

Ducks,
Dscho
