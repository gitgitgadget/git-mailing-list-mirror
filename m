From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 20:54:18 +0000
Message-ID: <fccf5e49dc956e4330d4e670e734862a@192.168.1.222>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222> <94a0d4530912290658m70075ad1u95e3692c01fb44b7@mail.gmail.com> <5b4ce0d0c1dd830782397602a71bb4f6@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 21:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPj4S-0002OU-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 21:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZL2Uxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZL2Uxb
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 15:53:31 -0500
Received: from mailrly07.isp.novis.pt ([195.23.133.217]:59309 "EHLO
	mailrly07.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbZL2Uxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 15:53:30 -0500
Received: (qmail 5729 invoked from network); 29 Dec 2009 20:53:28 -0000
Received: from unknown (HELO mailfrt08.isp.novis.pt) ([195.23.133.200])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly07.isp.novis.pt with compressed SMTP; 29 Dec 2009 20:53:28 -0000
Received: (qmail 28546 invoked from network); 29 Dec 2009 20:53:28 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt08.isp.novis.pt with SMTP; 29 Dec 2009 20:53:28 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id 7E0151A42D4;
	Tue, 29 Dec 2009 20:54:18 +0000 (WET)
In-Reply-To: <5b4ce0d0c1dd830782397602a71bb4f6@192.168.1.222>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135820>

Guys!

I changed on /etc/cgitrc:

css=cgit.css
logo=cgit.png

to:

css=/cgit/cgit.css
logo=/cgit/cgit.png

Forcing the path for the files to be from the root did the trick!
Thanks you all this the help!
