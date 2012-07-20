From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git with large files...
Date: Fri, 20 Jul 2012 15:54:46 -0700
Message-ID: <86fw8mf3gp.fsf@red.stonehenge.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Darek Bridges <darek.bridges@me.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 00:54:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsM64-0000VK-0Y
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 00:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab2GTWyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 18:54:51 -0400
Received: from lax-gw18.mailroute.net ([199.89.0.118]:58429 "EHLO
	gw18.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2GTWyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 18:54:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw18.lax01.mailroute.net (Postfix) with ESMTP id 48AFF179A28B;
	Fri, 20 Jul 2012 22:54:48 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw18.lax01.mailroute.net ([199.89.0.118])
	by localhost (gw18.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id BKaZBA4IFGSx; Fri, 20 Jul 2012 22:54:47 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw18.lax01.mailroute.net (Postfix) with ESMTP id 45D4D179A3AF;
	Fri, 20 Jul 2012 22:54:47 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 53AEF33D0; Fri, 20 Jul 2012 15:54:46 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.10.6; tzolkin = 6 Cimi; haab = 9 Xul
In-Reply-To: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com> (Darek Bridges's
	message of "Fri, 20 Jul 2012 12:27:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201796>

>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:

Darek> I use git for many things, but I am trying to work out the
Darek> workflow to use git for deployment.

Don't.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
