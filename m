From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: gitweb.cgi in C
Date: 08 Dec 2005 20:42:35 -0800
Message-ID: <86irtyank4.fsf@blue.stonehenge.com>
References: <43988299.4090101@tiscali.cz> <20051208222759.GO22159@pasky.or.cz>
	<7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
	<20051208224626.GP22159@pasky.or.cz>
	<7vhd9j9k3e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 05:44:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eka65-0006dA-NP
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 05:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVLIEmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 23:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVLIEml
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 23:42:41 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:64928 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751279AbVLIEml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 23:42:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A34AA8F763;
	Thu,  8 Dec 2005 20:42:36 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31729-01-10; Thu,  8 Dec 2005 20:42:36 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 448D68F7D7; Thu,  8 Dec 2005 20:42:36 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.15.10; tzolkin = 8 Oc; haab = 8 Mac
In-Reply-To: <7vhd9j9k3e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13412>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

>> I'd see having Perl XS for libgit as something much more sensible. And
>> you could do cute porcelain stuff with that as well.

Junio> Yes, that is exactly what I meant by what Smurf is working on --
Junio> libified git with Pyrex.

Pyrex?  not XS?  I'd like to see Perl "use Git;". :)


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
