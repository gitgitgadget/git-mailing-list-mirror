From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 16:28:36 +0200
Message-ID: <87y592y67f.fsf@igel.home>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 16:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Bfp-0003nZ-Oa
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 16:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab3GSO2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 10:28:41 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40752 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab3GSO2l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 10:28:41 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3bxZMV5dQsz3hhmV;
	Fri, 19 Jul 2013 16:28:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3bxZMV5NVjzbbsM;
	Fri, 19 Jul 2013 16:28:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id H1_9ptoiGjHF; Fri, 19 Jul 2013 16:28:37 +0200 (CEST)
X-Auth-Info: Po7/4NIMI8yAqWj4sPDsW9uPKqCqaKkLVMSMK+oFQ3s=
Received: from igel.home (ppp-88-217-119-182.dynamic.mnet-online.de [88.217.119.182])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 19 Jul 2013 16:28:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 870C0E498A; Fri, 19 Jul 2013 16:28:37 +0200 (CEST)
X-Yow: Somewhere in suburban Honolulu, an unemployed bellhop is whipping up
 a batch of illegal psilocybin chop suey!!
In-Reply-To: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Jul 2013 16:05:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230807>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>   # er, what was the branch name again?
>   $ git checkout -

You could take a look in the reflog.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
