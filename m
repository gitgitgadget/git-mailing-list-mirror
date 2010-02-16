From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 21:57:33 +0100
Message-ID: <20100216205732.GB1860@book.hvoigt.net>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> <20100216180209.GA1532@book.hvoigt.net> <7vocjpng1w.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:57:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhUUI-0004zG-5v
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 21:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283Ab0BPU5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 15:57:37 -0500
Received: from darksea.de ([83.133.111.250]:40350 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933078Ab0BPU5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 15:57:36 -0500
Received: (qmail 18027 invoked from network); 16 Feb 2010 21:57:32 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 16 Feb 2010 21:57:32 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140157>

On Tue, Feb 16, 2010 at 03:00:47PM -0500, Nicolas Pitre wrote:
> On Tue, 16 Feb 2010, Junio C Hamano wrote:
> 
> [...]
> > Notice how your version (xyzzy) broke the cascade of if..elseif..else.
> > 
> > Don't they teach this in schools anymore?
> 
> What do you expect from academia?  School and real life are still too 
> often disconnected.

If you want to offend people that try to help out in real life. This is
exactly the kind of comment that does it.
