From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Mon, 22 Aug 2011 22:00:52 +0200
Message-ID: <20110822200052.GC11745@sandbox-rc>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
 <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
 <20110811195955.GA21185@book.hvoigt.net>
 <7vy5yujtr2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 22:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvag6-0001Oo-UN
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 22:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab1HVUAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 16:00:55 -0400
Received: from darksea.de ([83.133.111.250]:40607 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752588Ab1HVUAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 16:00:53 -0400
Received: (qmail 31583 invoked from network); 22 Aug 2011 22:00:52 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Aug 2011 22:00:52 +0200
Content-Disposition: inline
In-Reply-To: <7vy5yujtr2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179885>

Hi,

On Mon, Aug 15, 2011 at 01:37:53PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > On Thu, Aug 11, 2011 at 11:28:31AM -0700, Junio C Hamano wrote:
> >> Heiko Voigt <hvoigt@hvoigt.net> writes:
> >> > We have been talking about loose submodules for some time:
> >> 
> >> Also before introducing a new terminology "loose submodule", please define
> >> it somewhere. It feels confusing to me that a normal submodule, which
> >> shouldn't be auto-cloned nor auto-updated without "submodule init", needs
> >> to be called by a name other than simply a "submodule" but with an
> >> adjuctive "loose submodule".
> >
> > Thats why I avoided talking about it in the docs. For the commit message
> > I thought it would be kind of intuitive but I can update the commit
> > message so that it becomes more clear.
> 
> That sounds like a good thing to do.

I discovered that I only talked in the cover letter about the term
'loose'. Since that will not go into any commit I guess we can keep the
series this way?

Cheers Heiko
