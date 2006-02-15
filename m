From: Martin Mares <mj@ucw.cz>
Subject: Re: Shared repositories and umask
Date: Wed, 15 Feb 2006 15:06:22 +0100
Message-ID: <mj+md-20060215.140603.2281.atrey@ucw.cz>
References: <mj+md-20060215.120104.14337.atrey@ucw.cz> <20060215130538.GO31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 15:06:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9NIY-0005MB-9L
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 15:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbWBOOGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 09:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945953AbWBOOGX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 09:06:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60046 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1945945AbWBOOGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 09:06:23 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 1000)
	id 7FF454B4272; Wed, 15 Feb 2006 15:06:22 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060215130538.GO31278@pasky.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16244>

>   Therefore, it shouldn't be actually necessary to meddle with umask
> anymore. The documentation is obsolete; I'll remove the relevant bits
> from Cogito docs.

Thanks for the hint!

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
First law of socio-genetics: Celibacy is not hereditary.
