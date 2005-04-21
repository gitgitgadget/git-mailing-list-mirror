From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Missing linefeeds
Date: Thu, 21 Apr 2005 18:26:14 +0200
Message-ID: <20050421162614.GF30991@pasky.ji.cz>
References: <20050421124430.ACDC77F894@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 18:23:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOeS6-0004kC-Qb
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVDUQ1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVDUQ1C
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:27:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60034 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261517AbVDUQ0X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 12:26:23 -0400
Received: (qmail 1214 invoked by uid 2001); 21 Apr 2005 16:26:14 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050421124430.ACDC77F894@smurf.noris.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 02:44:30PM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> This patch fixes die() and error() to print linefeeds after the message.

Why? report() already prints linefeed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
