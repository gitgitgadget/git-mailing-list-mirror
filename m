From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: RE: v2.5.2 installation on Windows 10
Date: Sat, 12 Sep 2015 13:56:29 +0200
Organization: gmx
Message-ID: <9fdf16cff4e2468a3a013ac2f13ac060@dscho.org>
References: <loom.20150911T181145-207@post.gmane.org>
 <a64946ac120a98fc1058bd194153cd0b@dscho.org>
 <01a501d0ed50$48b19ab0$da14d010$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Long Yang <gimmely@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 13:56:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZajQ6-0001QI-CD
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 13:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbbILL4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 07:56:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:64664 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488AbbILL4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 07:56:32 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LzbXq-1YXVRU0E78-014kV2; Sat, 12 Sep 2015 13:56:30
 +0200
In-Reply-To: <01a501d0ed50$48b19ab0$da14d010$@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:CFw1fDz+Ktn4VVfmcbPKVGvszBRNIaI0pFcGbus1L6UpYBmoQ3Z
 UWwKcQtBvlKYFOHkd9wJL6eW7qs8BCcfS5q+pD9Cy7jwZS/fhTiL56ZywOUTBawwxj1Mh/C
 4L3bMm7TpqvHO3ioQ46LOt7zDUieqtXonDfmT34Bmq1H/mcotdfSGgnQs/zTgD6NMtzYVkI
 WI6Dy1+JD4PNYXQ4sZOvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ccFaT5MEOK0=:DLWu6r4/k8NTq8PXSrlbV7
 4a+RH2137i8biIjmEyAfbsWT5HWs186HwiOCkqvHFeG4Hy18LSKlTJWtEnuZNv/JCoJe4JoTU
 s7fJEOt1SUJkTFFMxTRPmN50ddikrgH2VCBQSbXDzZia03knQQLMxhRwfMKX3WJEQomxx8AKX
 MHX+9yYXQeKPRbNfF36pedwwaToypUneizRNnc1q0Nf5h84r3oCtRlnsDSpVlSB9uZZ2Kn9VW
 nLWffqmcWQgS5KW/nIvAruBtqZwCatk5OHbc95eqGqtdtCy5nQkc5Q80Qlx4DYIba30VK9bCZ
 6HefcILldL0ieUQC4s3K9T/IrRvU90gi0urGCgiqhtpUuWbHtRNSI9UXBjivYTI1t/C7BcMeG
 hPYe4iSiDx+wjtVb8q9DpQKiJixYofL3TvzHvnZ/UKkYVBX3JZwdQMDp6QeP/zbuIP1ssk1CI
 hb/HcUHU7c3bjGaO78N5kyTzzTfypAgSJaigVcrgMTSKmdZdvBZXArrdSlZp68vu/qbdbuR3x
 dj4HekMxFINuRxtxgDyhvM4G6mIcc4kRGWs1ALm8PRlPQZ1tP3Js6Wu+gjPdjG3B6kXU6gN2V
 DXHRywrs3fSfC950WF37VT1oRfV5MOWP9SMDyB3fgEsWBkxp18Our1gfVogahpABOT2gXJQwY
 KhDZoTfeelUkG5+Nm0tFXzpxDMRhZKxGTxbQPsFodmWGfrlwde6jzupxLNPmvQaJUcF5xDqYc
 uS8nk85c4xAzO/s5IvMIso4gEnVPC6cTxMKA4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277725>

Hi Long,

On 2015-09-12 13:43, Long Yang wrote:

> Thanks for the email to confirm the bug.

Of course! Thank you for taking the time to report it.

> To answer your question first, I found only the Community page at
> http://www.git-scm.com/, as I was looking for a forum-kind of page to
> see if someone had reported the same problem I had.  Then I tried to
> send a couple of emails to the mailing list, git@vger.kernel.org, as
> instructed on the Community page.  But none of my emails was
> delivered.  At the end, I post my case via gmane.

Thank you, I think I will open a Pull Request to that Community page to suggest going the GitHub issues route in case of Windows-specific bugs.

> In short, I still don't know how to successfully report a bug for Git.
>  Should I/users use GitHub?

If the bug in question is a Windows-specific bug, or if you do not know whether it is a Windows-specific bug, then yes, please submit it to our GitHub issue tracker, as described in the "Contribute" section of our home page: http://git-for-windows.github.io/#contribute

If you already know that the bug in question affects more than just Windows users, please report it to the Git mailing list, as you have done. (You will need to send plain-text messages, as the Git mailing list rejects HTML mails.)

Ciao,
Johannes
