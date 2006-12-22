From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git (stable)
Date: 22 Dec 2006 09:15:15 -0800
Message-ID: <86k60jsvh8.fsf@blue.stonehenge.com>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 18:15:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxnzP-0001Mz-S4
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 18:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWLVRPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 12:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWLVRPU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 12:15:20 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:23695 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbWLVRPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 12:15:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E10B88FA88;
	Fri, 22 Dec 2006 09:15:16 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17416-01-15; Fri, 22 Dec 2006 09:15:16 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0B5948FA8C; Fri, 22 Dec 2006 09:15:16 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.16.9; tzolkin = 10 Muluc; haab = 2 Kankin
In-Reply-To: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35187>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio>       git-pull: refuse default merge without branch.*.merge

Argh.  How do I get back the old behavior?
"git-pull origin" doesn't seem to be enough.

You just broke a bunch of automated scripts for me.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
