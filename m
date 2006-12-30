From: Raimund Bauer <ray007@gmx.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 30 Dec 2006 13:24:34 +0100
Message-ID: <45965A82.8030903@gmx.net>
References: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612292219280.18171@xanadu.home> <Pine.LNX.4.63.0612301217010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 13:24:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0dGe-0001L4-10
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 13:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbWL3MYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 07:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbWL3MYj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 07:24:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:36960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754371AbWL3MYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 07:24:38 -0500
Received: (qmail invoked by alias); 30 Dec 2006 12:24:36 -0000
Received: from p54988AF3.dip0.t-ipconnect.de (EHLO [127.0.0.1]) [84.152.138.243]
  by mail.gmx.net (mp023) with SMTP; 30 Dec 2006 13:24:36 +0100
X-Authenticated: #20693823
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.9) Gecko/20061207 Thunderbird/1.5.0.9 Mnenhy/0.7.4.0
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612301217010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35618>

* Johannes Schindelin wrote, On 30.12.2006 12:22:
> (Of course, the correct thing would not be "git reset --hard", but rather 
> "git diff --ours | git apply -R; git reset", but that's a tad long, no?)
Then maybe introduce "git reset --ours" which does exactly that?

-- 
best regards

  Ray
