From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Sat, 20 May 2006 19:16:22 -0600
Message-ID: <m1u07kp47t.fsf@ebiederm.dsl.xmission.com>
References: <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
	<m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
	<20060519235825.GA3289@kroah.com>
	<m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
	<20060520213257.GH24672@kroah.com>
	<m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com>
	<7v8xow1a6r.fsf@assigned-by-dhcp.cox.net>
	<m13bf4qjjv.fsf@ebiederm.dsl.xmission.com>
	<7v4pzk196p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:17:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhcZC-0003F9-FJ
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWEUBRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEUBRH
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:17:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50119 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964847AbWEUBRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:17:05 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4L1GNQl004365;
	Sat, 20 May 2006 19:16:23 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4L1GNuR004364;
	Sat, 20 May 2006 19:16:23 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pzk196p.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 20 May 2006 18:02:54 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20420>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Where git-mailinfo is likely to fall down is more in the quilt
>> patches from Andi Kleen. If you look at my quoted patch header below
>> you will see the subject is a plain line, followed by a space followed
>> by a from.  On this example git-mailinfo works (except for picking up
>> the subject) but it appears to be a fluke.
>>
>> From x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-sysfs.patch:
>>
>
> Yeah, that's right, but in a real mailbox wouldn't that line be
> prefixed with a '>' ;-)?

That last from line was my attribution.  The first quoted line
was the first line of the patch.  In this context that was probably
a little confusing.

Eric
