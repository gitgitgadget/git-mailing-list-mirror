From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git
Date: 09 May 2006 21:36:43 -0700
Message-ID: <864pzyh4x0.fsf@blue.stonehenge.com>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 06:38:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdgRQ-0007fn-0r
	for gcvg-git@gmane.org; Wed, 10 May 2006 06:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWEJEgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 00:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWEJEgp
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 00:36:45 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:60071 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964797AbWEJEgo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 00:36:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 03A2C8F564;
	Tue,  9 May 2006 21:36:44 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 04535-01-26; Tue,  9 May 2006 21:36:43 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 76BA28F569; Tue,  9 May 2006 21:36:43 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.5.2; tzolkin = 4 Ik; haab = 15 Uo
In-Reply-To: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19872>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> This week's "What's in" is a day early, since I do not expect to
Junio> be able to do much gitting for the rest of the week.

I just got this with the latest, on the git archive, using git-repack -a:

Generating pack...
Done counting 19151 objects.
Deltifying 19151 objects.
Segmentation fault (core dumped)

This is on OpenBSD.  Is there a secret sabotage afoot?  This is repeatable.
Is there anything I can try differently?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
