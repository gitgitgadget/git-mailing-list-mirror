From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-name-rev off-by-one bug
Date: 01 Dec 2005 13:53:06 -0800
Message-ID: <86sltclc1p.fsf@blue.stonehenge.com>
References: <20051128234256.1508.qmail@science.horizon.com>
	<7vd5khjf9g.fsf@assigned-by-dhcp.cox.net>
	<20051201215039.GX22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, linux@horizon.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 22:57:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhwMz-0004ED-Ag
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVLAVxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVLAVxM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:53:12 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:57132 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932503AbVLAVxK
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 16:53:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id D7CE88F777;
	Thu,  1 Dec 2005 13:53:06 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20251-02-22; Thu,  1 Dec 2005 13:53:06 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 71E208F803; Thu,  1 Dec 2005 13:53:06 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.15.3; tzolkin = 1 Akbal; haab = 1 Mac
In-Reply-To: <20051201215039.GX22159@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13079>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> I'm still perplexed and curious about what _did_ git-send-pack actually
Petr> receive as URL, since it apparnetly decided it's ssh as well.

Sorry... $work is swallowing my time right now.  It's on my list
of "very important things to get back to sometime real soon".

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
