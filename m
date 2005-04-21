From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Errors received during git pull from linux-2.6.git, but resulting kernel looks OK.
Date: Thu, 21 Apr 2005 18:04:30 +0200
Message-ID: <20050421160430.GA30991@pasky.ji.cz>
References: <4267B0CE.7020504@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:01:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOe6C-0000o5-2g
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVDUQEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVDUQEk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:04:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28290 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261486AbVDUQEf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 12:04:35 -0400
Received: (qmail 31639 invoked by uid 2001); 21 Apr 2005 16:04:30 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <4267B0CE.7020504@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 03:55:26PM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> Executive summary: I received some alarming errors while doing
> a git pull of the latest kernel from kernel.org, but it appears
> that all is well.  Continue reading for the gory details.

It seems that the directory cache format changed since you pulled the
last time.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
