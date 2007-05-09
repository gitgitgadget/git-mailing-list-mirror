From: Petr Baudis <pasky@suse.cz>
Subject: Re: Wiki front page pointing to HelpOnLanguages
Date: Wed, 9 May 2007 18:26:54 +0200
Message-ID: <20070509162654.GZ4489@pasky.or.cz>
References: <vpqr6pu9bdl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 18:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlp0H-0001gF-4O
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbXEIQ05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbXEIQ05
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:26:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59301 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755897AbXEIQ04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:26:56 -0400
Received: (qmail 3974 invoked by uid 2001); 9 May 2007 18:26:54 +0200
Content-Disposition: inline
In-Reply-To: <vpqr6pu9bdl.fsf@bauges.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46742>

  Hi,

On Sun, May 06, 2007 at 06:15:34PM CEST, Matthieu Moy wrote:
> Both the URL http://git.or.cz/gitwiki/ and the link "GitWiki" on the
> top-left corner of the wiki seem to point to
> http://git.or.cz/gitwiki/HelpOnLanguages which is a MoinMoin-dedicated
> page, but very confusing for someone looking for informations about
> git.
> 
> Reproduced with both Firefox, Konqueror and links, configured in
> English AFAICT, from two different machines.

  yes, thanks for the report - I fixed it on Monday, but didn't notice
your mail before now. One of the admins upgraded the machine to etch
when I was not looking and it caused some bits to break. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
