From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 11:27:04 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
 <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 17:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYMwY-0003uv-HZ
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 17:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYH0P1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbYH0P1I
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 11:27:08 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:36328 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbYH0P1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 11:27:07 -0400
X-Greylist: delayed 66419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2008 11:27:07 EDT
Received: from gandalf ([74.74.65.243]) by hrndva-omta03.mail.rr.com
          with ESMTP
          id <20080827152705.GNPE25274.hrndva-omta03.mail.rr.com@gandalf>;
          Wed, 27 Aug 2008 15:27:05 +0000
X-X-Sender: rostedt@gandalf.stny.rr.com
In-Reply-To: <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93895>


On Tue, 26 Aug 2008, Perry Wagle wrote:
> 
> I'm trying to upgrade the git that our scripts use, and having the  
> users modify their paths doesn't work.
> 
> Not that horrible to fix some other way, but still a rude thing to  
> wake up to one day. (ie, today)
> 

Did you see the yellow bulldozer coming at your house while brushing your 
teeth?

-- Steve
