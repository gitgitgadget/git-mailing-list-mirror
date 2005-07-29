From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 4/2] Improve the compilation-time settings interface
Date: Fri, 29 Jul 2005 20:23:56 +0200
Message-ID: <20050729182356.GA22530@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz> <20050729154826.GG21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 20:27:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyZYz-0000CN-2o
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 20:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVG2SYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVG2SYd
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 14:24:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43268 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262697AbVG2SX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 14:23:58 -0400
Received: (qmail 22875 invoked by uid 2001); 29 Jul 2005 18:23:56 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729154826.GG21909@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 05:48:26PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> told me that...
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -1,33 +1,53 @@
> +# Define NO_OPENSSL environment variable if you do not have OpenSSL. You will
> +# miss out git-rev-list --merge-order. This also implies MOZILLA_SHA1.

Sorry for this, I didn't realize until much later that NO_OPENSSL wasn't
actually in git yet. I hope I won't have to resend the patches just
because of this. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
