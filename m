From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Fix git_config_set() for mean cases
Date: 16 Nov 2005 17:40:20 -0800
Message-ID: <86br0kjbln.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0511161045310.16596@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vhdac738c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511170013470.9284@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 02:41:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcYlJ-00012y-Hk
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 02:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbVKQBk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 20:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbVKQBk0
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 20:40:26 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:9529 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1030547AbVKQBk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 20:40:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A92FA8F5CC;
	Wed, 16 Nov 2005 17:40:21 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 16510-03; Wed, 16 Nov 2005 17:40:21 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 377B88F5CD; Wed, 16 Nov 2005 17:40:21 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.12.14.8; tzolkin = 12 Lamat; haab = 6 Ceh
In-Reply-To: <Pine.LNX.4.63.0511170013470.9284@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12082>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Besides, the character is there, so why not use it? ;-)

It reminds me of when people typed "l" instead of "1" because typewriters
didn't have a "1".

In that manner, it's just plain wrong.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
