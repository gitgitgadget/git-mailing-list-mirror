From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: gitweb.cgi in C
Date: 09 Dec 2005 07:45:57 -0800
Message-ID: <86r78m8ea2.fsf@blue.stonehenge.com>
References: <20051209152847.28358.qmail@web34310.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 16:49:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkkRp-0000dh-GS
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 16:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVLIPqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 10:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVLIPqF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 10:46:05 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:39000 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964776AbVLIPqD
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 10:46:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 9642E8FA1F;
	Fri,  9 Dec 2005 07:45:58 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 02519-01-70; Fri,  9 Dec 2005 07:45:58 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1C81E8FA20; Fri,  9 Dec 2005 07:45:58 -0800 (PST)
To: Mark Allen <mrallen1@yahoo.com>
x-mayan-date: Long count = 12.19.12.15.11; tzolkin = 9 Chuen; haab = 9 Mac
In-Reply-To: <20051209152847.28358.qmail@web34310.mail.mud.yahoo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13428>

>>>>> "Mark" == Mark Allen <mrallen1@yahoo.com> writes:

Mark> I started working on a GIT-XS project around GIT 0.9 timeframe, but the changes to APIs
Mark> and calls was still way too rapid, so I decided to back burner it. 

Mark> I haven't looked at the libification work that Smurf is doing (haven't made time for it
Mark> lately), but if it's not TOO python specific, maybe I can use it too.

A "lite" version using Inline::C can be quickly constructed if
only the API were all listed in one place, or a few easy to find places.

I spent about ten minutes trying to find this information a few weeks
back, but apparently, that was about five minutes (or more) too short.

Any quick pointers on how -lgit is constructed?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
