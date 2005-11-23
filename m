From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: 23 Nov 2005 06:29:11 -0800
Message-ID: <86acfvphe0.fsf@blue.stonehenge.com>
References: <200511231141.57683.lan@ac-sw.com>
	<867jazre78.fsf@blue.stonehenge.com>
	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
	<200511231619.41497.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 15:31:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eevcm-0004D1-R8
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKWO30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKWO30
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:29:26 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:48713 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750824AbVKWO3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:29:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 254B28F73C;
	Wed, 23 Nov 2005 06:29:25 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 18613-01-36; Wed, 23 Nov 2005 06:29:11 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E79F08F747; Wed, 23 Nov 2005 06:29:11 -0800 (PST)
To: Alexander Litvinov <lan@ac-sw.com>
x-mayan-date: Long count = 12.19.12.14.15; tzolkin = 6 Men; haab = 13 Ceh
In-Reply-To: <200511231619.41497.lan@ac-sw.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12626>

>>>>> "Alexander" == Alexander Litvinov <lan@ac-sw.com> writes:

Alexander> I have made this change. I also belive it will work on earlier perl but I 
Alexander> can't test this.

This patch looks good back to 5.5.  I didn't execute it either, but
the Perl version installed in my head gave it a thumbs-up. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
