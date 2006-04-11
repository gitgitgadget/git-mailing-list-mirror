From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git log [diff-tree options]...
Date: 10 Apr 2006 17:50:26 -0700
Message-ID: <861ww5aqb1.fsf@blue.stonehenge.com>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
	<Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
	<86k69xasg0.fsf@blue.stonehenge.com>
	<7vveth6kdg.fsf@assigned-by-dhcp.cox.net>
	<20060411003126.GX27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 02:50:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT75g-00074n-LD
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 02:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWDKAud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 20:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWDKAuc
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 20:50:32 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:39290 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932207AbWDKAuc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 20:50:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id AE12F8F3A1;
	Mon, 10 Apr 2006 17:50:27 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17179-01; Mon, 10 Apr 2006 17:50:26 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C8D428F39D; Mon, 10 Apr 2006 17:50:26 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.13.3.13; tzolkin = 1 Ben; haab = 6 Pop
In-Reply-To: <20060411003126.GX27689@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18607>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> Dear diary, on Tue, Apr 11, 2006 at 02:12:11AM CEST, I got a letter
Petr> where Junio C Hamano <junkio@cox.net> said that...
>> There is no reason for them to be *absolutely* identical

Petr> One is that people expect them to be. It's been implied that "git xyzzy"
Petr> is functionally fully equivalent to "git-xyzzy" for too long to silently
Petr> break this now.

Yes, this is what I was referencing.  I would *never* have considered
that git-log and "git log" be different things now that it's been firmly
engrained that they are the same.  Please don't violate the model.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
