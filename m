From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: How to build manpages on OS X
Date: 28 Dec 2006 22:02:55 -0800
Message-ID: <867iwbdysw.fsf@blue.stonehenge.com>
References: <459453F8.1010200@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 07:03:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Apb-0007An-E4
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 07:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWL2GC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 01:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWL2GC6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 01:02:58 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:7295 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964966AbWL2GC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 01:02:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C81A38FB72;
	Thu, 28 Dec 2006 22:02:56 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31311-01-79; Thu, 28 Dec 2006 22:02:55 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id DEA9C8FB75; Thu, 28 Dec 2006 22:02:55 -0800 (PST)
To: Steven Grimm <koreth@midwinter.com>
x-mayan-date: Long count = 12.19.13.16.15; tzolkin = 3 Men; haab = 8 Kankin
In-Reply-To: <459453F8.1010200@midwinter.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35584>

>>>>> "Steven" == Steven Grimm <koreth@midwinter.com> writes:

Steven> Didn't see this documented anywhere, so...
Steven> If you want to do a full build of git on OS X including the manpages, you need
Steven> the asciidoc and xmlto packages. Both of them are available from macports.org
Steven> (formerly known as DarwinPorts) but out of the box, they don't work quite
Steven> right.

I'm using the ones out of fink, and it seems to work just fine.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
