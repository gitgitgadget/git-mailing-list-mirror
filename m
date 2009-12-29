From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 15:21:03 +0000
Message-ID: <11086b46ef152d6e2aadb1c5f655fe72@192.168.1.222>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222> <94a0d4530912290658m70075ad1u95e3692c01fb44b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 16:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdsL-0006Ok-MD
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 16:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbZL2PU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZL2PUX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 10:20:23 -0500
Received: from mailrly04.isp.novis.pt ([195.23.133.224]:56105 "EHLO
	mailrly04.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbZL2PUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 10:20:18 -0500
Received: (qmail 11570 invoked from network); 29 Dec 2009 15:20:16 -0000
Received: from unknown (HELO mailfrt07.isp.novis.pt) ([195.23.133.199])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly04.isp.novis.pt with compressed SMTP; 29 Dec 2009 15:20:16 -0000
Received: (qmail 22859 invoked from network); 29 Dec 2009 15:20:15 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt07.isp.novis.pt with SMTP; 29 Dec 2009 15:20:15 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id C1BF73D53B;
	Tue, 29 Dec 2009 15:21:03 +0000 (WET)
In-Reply-To: <94a0d4530912290658m70075ad1u95e3692c01fb44b7@mail.gmail.com>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135806>

> This is what I do:
> ScriptAlias /cgit /var/www/cgit-files/cgit.cgi
> 
> You need a new cgit to use that properly, I use 0.8.3.

I tried that way, no luck, apache always show on the errors that cannot
create the lock slot and it show all unconfigured on the page.
