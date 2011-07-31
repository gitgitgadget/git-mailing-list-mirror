From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 18:16:35 +0200
Message-ID: <4E357FE3.1040205@lsrfire.ath.cx>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com> <CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com> <4E350F15.9050009@lsrfire.ath.cx> <CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Nahas <mike.nahas@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6?= =?ISO-8859-1?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Sun Jul 31 18:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnYhX-0000r8-CI
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 18:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1GaQQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 12:16:57 -0400
Received: from india601.server4you.de ([85.25.151.105]:56229 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab1GaQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 12:16:56 -0400
Received: from [192.168.2.104] (p579BEE49.dip.t-dialin.net [87.155.238.73])
	by india601.server4you.de (Postfix) with ESMTPSA id 4BA992F803A;
	Sun, 31 Jul 2011 18:16:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178264>

Am 31.07.2011 16:13, schrieb Michael Nahas:
> I don't doubt that there exists current commands in git that can perf=
orm
> operations like cat, ls, etc.  My point is that git can make it easie=
r
> for new users to learn commands and existing users to remember comman=
ds
> if git copies the name and sematics (as much as possible) of cat, ls,=
 etc.

Possibly.  My point was that for this example a look-alike was easy to
implement as an alias or shell script using an existing plumbing
command.  You can probably get quite far to your goal that way.

Ren=E9
