From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Wed, 17 Feb 2010 18:56:01 +0100
Message-ID: <20100217175600.GB2251@book.hvoigt.net>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> <20100216180209.GA1532@book.hvoigt.net> <7vocjpng1w.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002161458410.1946@xanadu.home> <20100216205732.GB1860@book.hvoigt.net> <alpine.LFD.2.00.1002161606570.1946@xanadu.home> <7v1vgk94gq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 18:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nho8E-0007Ko-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 18:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab0BQR4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 12:56:07 -0500
Received: from darksea.de ([83.133.111.250]:51481 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753421Ab0BQR4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 12:56:05 -0500
Received: (qmail 21999 invoked from network); 17 Feb 2010 18:56:00 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2010 18:56:00 +0100
Content-Disposition: inline
In-Reply-To: <7v1vgk94gq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140240>

On Tue, Feb 16, 2010 at 02:54:29PM -0800, Junio C Hamano wrote:
> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Tue, 16 Feb 2010, Heiko Voigt wrote:
> >
> >> On Tue, Feb 16, 2010 at 03:00:47PM -0500, Nicolas Pitre wrote:
> >> > What do you expect from academia?  School and real life are still too 
> >> > often disconnected.
> >> 
> >> If you want to offend people that try to help out in real life. This is
> >> exactly the kind of comment that does it.
> >
> > Because you think that I'm not giving my own time helping people solving 
> > real life issues? If so I'd suggest you do a quick background check on 
> > myself.
> 
> I don't think Heiko is saying he was offended by you, but is saying he was
> offended by me saying "Don't they teach this in schools anymore?"  I was
> simply curious about the answer to that question.  If they don't teach C,
> it is not Heiko's fault---no need to get offended.  I admit that I did go
> "Huh?  Never repeat?  What's the point?" when I first saw the idiom.

It was actually the combination of both ;) But I am glad we could sort
this out. I simply had the same thought as you when I saw this first and
then confused it with the typical sleep(0) you use for forcing thread
switches.

BTW, we had a course of C but for macros they stopped at "type them
uppercase and try to avoid them when possible". Everything else is
learning by experience.

cheers Heiko
