From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Removing git-*.html references from manpages
Date: Wed, 8 Jun 2005 20:59:14 +0200
Message-ID: <20050608185914.GJ982@pasky.ji.cz>
References: <20050527225850.GA25491@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:57:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg5i0-00026o-7P
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 20:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFHS7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVFHS7U
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 14:59:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52703 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261532AbVFHS7Q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 14:59:16 -0400
Received: (qmail 7005 invoked by uid 2001); 8 Jun 2005 18:59:14 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050527225850.GA25491@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 28, 2005 at 12:58:50AM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Hello,

Hi,

> What do you think?

so, what do people think? It sounds as a good thing, but I miss any
discussion. I assume that means everyone likes it? ;-)

> --- a/Documentation/git.txt  (mode:100644)
> +++ b/Documentation/git.txt  (mode:100644)
> @@ -39,34 +39,34 @@
>  
>  Manipulation commands
>  ~~~~~~~~~~~~~~~~~~~~~
> -link:git-checkout-cache.html[git-checkout-cache]::
> +gitlink:git-checkout-cache.html[git-checkout-cache]::
>  	Copy files from the cache to the working directory

So wasn't the point that this would rather be

	+gitlink:git-checkout-cache::

than to what you change it to now?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
