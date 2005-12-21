From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Am I doing something wrong?
Date: 21 Dec 2005 09:54:57 -0800
Message-ID: <864q52xrm6.fsf@blue.stonehenge.com>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	<7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 18:58:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8B3-0000Hk-2A
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 18:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVLURy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVLURy6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 12:54:58 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:10373 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751149AbVLURy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 12:54:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id ADB528F94F;
	Wed, 21 Dec 2005 09:54:57 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31870-01-83; Wed, 21 Dec 2005 09:54:57 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3BB558F950; Wed, 21 Dec 2005 09:54:57 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.16.3; tzolkin = 8 Akbal; haab = 1 Kankin
In-Reply-To: <7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13884>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> localhost:~/MIRROR/git-GIT % cg-fetch
>> Recovering from a previously interrupted fetch...

Junio> Sorry, I do not know what Cogito is doing there (the message is
Junio> from an "echo" in cg-fetch).  git-clone over HTTP seems to work
Junio> for me, and I just tried git-fetch over HTTP in my random
Junio> back-up repo that happened to be at around 0.99.9g without
Junio> problems, so I am reasonably sure the public repository is not
Junio> corrupt.

It worked once I changed the URL from http://www to git://git

Perhaps something is wrong with the archive when viewed with HTTP protocol?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
