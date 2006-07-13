From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb.css: Courer fonts for commits and tree-diff
Date: Thu, 13 Jul 2006 09:57:39 +0200
Message-ID: <E1G0w4p-0007c9-O3@moooo.ath.cx>
References: <7vac7f1htw.fsf@assigned-by-dhcp.cox.net> <20060712174610.71046.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 09:58:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0w4w-0001LS-Fi
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 09:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWGMH5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 03:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWGMH5n
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 03:57:43 -0400
Received: from moooo.ath.cx ([85.116.203.178]:12240 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964842AbWGMH5n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 03:57:43 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
Mail-Followup-To: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060712174610.71046.qmail@web31810.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23822>

Luben Tuikov <ltuikov@yahoo.com> wrote:
> --- Junio C Hamano <junkio@cox.net> wrote:
> > But if I really have to, I would say this makes things uglier
> > and less readable.  Maybe asking for monospace is less yucky but
> > naming Courier explicitly?
> 
> Sometimes people would put ASCII art in their commit messages,
> things like a simple table, compiler output, log output, etc,
> and I wanted to _preserve_ the intent of such output.  This is why
> I changed it to Courier. (sorry for the misspelling of Courier)
monospace should do this too, see[1].  I think it should be added as
fallback[2] at least but I see no reason not to use font-family:
monospace.

[1] http://www.w3.org/TR/REC-CSS2/fonts.html#monospace-def
[2] http://www.w3.org/TR/REC-CSS2/fonts.html#generic-font-families
