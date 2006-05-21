From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Sat, 20 May 2006 18:02:54 -0700
Message-ID: <7v4pzk196p.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:03:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhcLU-0001mz-95
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWEUBC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWEUBC5
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:02:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43957 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932294AbWEUBC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:02:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521010256.MPGQ25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 May 2006 21:02:56 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m13bf4qjjv.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Sat, 20 May 2006 18:59:48 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20417>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Where git-mailinfo is likely to fall down is more in the quilt
> patches from Andi Kleen. If you look at my quoted patch header below
> you will see the subject is a plain line, followed by a space followed
> by a from.  On this example git-mailinfo works (except for picking up
> the subject) but it appears to be a fluke.
>
> From x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-sysfs.patch:
>

Yeah, that's right, but in a real mailbox wouldn't that line be
prefixed with a '>' ;-)?
