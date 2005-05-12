From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Improve option parsing for cg-log
Date: Thu, 12 May 2005 23:13:15 +0200
Message-ID: <20050512211315.GP324@pasky.ji.cz>
References: <1115931114.18499.66.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:06:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKsD-0004nl-Gh
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVELVNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVELVNT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:13:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52443 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261939AbVELVNR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 17:13:17 -0400
Received: (qmail 28601 invoked by uid 2001); 12 May 2005 21:13:15 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115931114.18499.66.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 10:51:54PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> the attached patch changes the option parsing, because otherwise we are
> stuck to a specific order.

thanks, applied. However, you didn't include the -r options parsing in
there yet.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
