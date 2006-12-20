From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
Date: 20 Dec 2006 15:58:38 -0800
Message-ID: <86ejquxgpd.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:55:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxD94-0003zM-HP
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWLUByv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWLUByt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:54:49 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:24770 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161131AbWLUBys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:54:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3D7D28FA32;
	Wed, 20 Dec 2006 17:54:48 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 06702-01-60; Wed, 20 Dec 2006 17:54:47 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E954A8FFE3; Wed, 20 Dec 2006 15:58:38 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35007>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> Master right  now is at 54851157ac.

On a more positive note, with my local (unacceptable) changes to muck with
headers, the 54 release does in fact make git-index-pack take
under a minute for 313037 objects on OSX.  Yeay!

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
