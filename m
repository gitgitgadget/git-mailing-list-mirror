From: Mark Polesky <markpolesky@yahoo.com>
Subject: gitk won't stay open
Date: Sat, 8 Aug 2009 16:44:00 -0700 (PDT)
Message-ID: <204834.32292.qm@web83403.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 01:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZvgW-0005vg-Ln
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 01:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbZHHXul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 19:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZHHXuk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 19:50:40 -0400
Received: from web83403.mail.sp1.yahoo.com ([69.147.64.51]:47737 "HELO
	web83403.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753131AbZHHXuk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2009 19:50:40 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Aug 2009 19:50:40 EDT
Received: (qmail 32520 invoked by uid 60001); 8 Aug 2009 23:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1249775041; bh=x5IIh7rmK+xOZysDKwVRo/yXz5CW87byeu2IC7UiuvY=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=O+1piesc4DvGjLxl56DYLvVTPdJcMk10WdBt4XNK26PEPr59w35R+1Lk7NeJTjBLuwVNjVKi5vL/QaZYh/ISHx84ZHY2d69hrfW3U25EW8d9hQf+VdqFTiV5MO96NPfeMfr2GOt+uh2H8kQkykS2ekA+lAngLu0AT+x6KfBaP50=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=MBotAtZMtQ+lX2M0Qsoh75I1Z6dJkCJVugEuA4Y17WE+rMUR9tGs24nV2Kz8fJVeNDLJd7JN6Unx215TpsHyje0z+vkwDQ1Lkvm2YIVMvicRPqa2DRhpSHarKEmq5C4LPRXjCPQaQX1XV8ng6+LW6fJvS9q0gQR+ZS+4Wo3y6EA=;
X-YMail-OSG: R9x1xz8VM1k1eAueZ5TvebR75mYD_XwFm.5JdQmUYbIvTWU..wx5NR7UjMNSLE7hhj3610wEmPlVQlZMweqGm3j4DmhKG0bJSLMObcfumpfJ8MiZ8OAxBR_JfGn66z.uaJc2ARt1vjuEiXieQpMQJmz0BwTxW_RCxoOakV1qKhD_rDFeMSzctyL9okrfqgE7YJbXeXbUEtZC9N2enwdsuh8ErRZaj..QnX8AZhIsHWMREAbK9acfHVlzPIULTPjPw9jV4dYJw3EJkfo82tQ4n7uyoHxICCzRg60IEzq.gXcswuGPRtKH6QoKPycOslRYO6tp
Received: from [72.220.150.208] by web83403.mail.sp1.yahoo.com via HTTP; Sat, 08 Aug 2009 16:44:00 PDT
X-Mailer: YahooMailRC/1358.27 YahooMailWebService/0.7.289.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125312>


Hi.

When I type gitk, the new window opens for about one
second, showing the history of commits, and then
quickly closes on its own. I'm on Windows XP.

Is there a known cause for this?

Thanks.
- Mark



      
