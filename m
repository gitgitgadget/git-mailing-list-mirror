From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] gitweb: Add title attribute with unshortened value
	for table cells
Date: Tue, 20 Jun 2006 16:28:35 +0100
Message-ID: <1150817316.17609.77.camel@hades.cambridge.redhat.com>
References: <200606201012.31684.jnareb@gmail.com>
	 <7vd5d4chmg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 17:28:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsi9Y-0003If-F4
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 17:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWFTP23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWFTP23
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 11:28:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21406 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751322AbWFTP22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 11:28:28 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1Fsi9R-0002tD-SZ; Tue, 20 Jun 2006 16:28:26 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5d4chmg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22208>

On Tue, 2006-06-20 at 02:15 -0700, Junio C Hamano wrote:
> I wonder if there is somebody who is willing to run gitweb from
> the "next" branch on some public site, so that I can be
> reasonably confident before breaking one of the most important
> infrastructure of the kernel development?  Volunteers? 

Yeah, we can do it on git.infradead.org if you promise to respond
quickly when you break it. Or I can set up a virtual host on
http://git2.infradead.org/ to use the testing version if you'd prefer.

Mail me a SSH public key, I'll give you an account.

-- 
dwmw2
