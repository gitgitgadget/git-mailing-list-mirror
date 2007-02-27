From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 07:09:06 -0800
Message-ID: <86odnfr625.fsf@blue.stonehenge.com>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:09:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM3x2-0007wQ-K7
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbXB0PJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbXB0PJI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:09:08 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:48399 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbXB0PJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:09:07 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id CEBDE1DEC55; Tue, 27 Feb 2007 07:09:06 -0800 (PST)
x-mayan-date: Long count = 12.19.14.1.16; tzolkin = 12 Cib; haab = 9 Kayab
In-Reply-To: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Tue, 27 Feb 2007 04:31:41 -0800")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40741>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Which is kind of depressing...

Maybe if you looked at who has been reporting the bugs, you'd find a different
story.  It's quite possible that the "inner circle" all used git in a
homogeneous way, not performing every possible advertised operation, but now
that git is being used by more people, older bugs are getting revealed because
people really are using it out there in some nicely unique (or perhaps
boneheaded :) ways.

Any quick stats on diversity of bug submitters?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
