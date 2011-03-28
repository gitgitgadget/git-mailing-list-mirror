From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git @ be919d50 broken on OSX build
Date: Mon, 28 Mar 2011 09:28:36 -0700
Message-ID: <86lizzi4zv.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 18:28:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4FJA-0004Lx-NA
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab1C1Q2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:28:42 -0400
Received: from lax-gw08.mailroute.net ([199.89.0.108]:54135 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754326Ab1C1Q2l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:28:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw08.mroute.net (Postfix) with ESMTP id 62FDF299E68
	for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:28:37 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw08.mroute.net (Postfix) with ESMTP id E0EF5299E61
	for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:28:36 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id DBE1818A4; Mon, 28 Mar 2011 09:28:36 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.4.6; tzolkin = 7 Cimi; haab = 19 Cumku
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170151>


...
    GEN git-add--interactive
Writing perl.mak for Git
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
make: *** [git-add--interactive] Error 2

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
