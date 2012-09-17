From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 19:08:51 +0200
Message-ID: <m2mx0o1srg.fsf@igel.home>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
	<vpqy5k8raig.fsf@grenoble-inp.fr>
	<CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
	<m2txuw1xcj.fsf@igel.home>
	<CALkWK0=cDW7BU6QofaeLbtETwzrnWBuuKcpgYNaM1x5tutisfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDeoj-0000lJ-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab2IQRI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:08:57 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59869 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2IQRI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:08:56 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XLDM80Pz8z3hhqR;
	Mon, 17 Sep 2012 19:08:52 +0200 (CEST)
X-Auth-Info: UmC/nSZtgUkOgemknwSDLq4laAtiEHQurctYUuTz8q4=
Received: from igel.home (ppp-93-104-139-127.dynamic.mnet-online.de [93.104.139.127])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XLDM775Mkzbbkx;
	Mon, 17 Sep 2012 19:08:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 9E073CA2A5; Mon, 17 Sep 2012 19:08:51 +0200 (CEST)
X-Yow: I just bought FLATBUSH from MICKEY MANTLE!
In-Reply-To: <CALkWK0=cDW7BU6QofaeLbtETwzrnWBuuKcpgYNaM1x5tutisfA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 17 Sep 2012 08:32:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205713>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Andreas,
>
> Andreas Schwab wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Hi Matthieu,
>>>
>>> Matthieu Moy wrote:
>>>> Do you have any user with this login (finger kseygold)? I suspect you
>>>> have two usernames with the same user ID.
>>>
>>> Login: kseygold                         Name: Seybold
>>
>> What about "id kseygold; id ramkum"?
>
> Apart from the UIDs matching, what do you find interesting about the output?

That the UIDs are the same.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
