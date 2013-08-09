From: Dmitry Kuzminov <dkuzminov@yandex-team.ru>
Subject: Re: Git for the Windows 1.8.3, GIT Bash icon issue
Date: Fri, 09 Aug 2013 22:43:18 +0400
Message-ID: <41401376073798@webcorp2d.yandex-team.ru>
References: <40631376067651@webcorp2d.yandex-team.ru> <FA03039F4A644EEE8CEEA25BCFDA1994@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>,
	Git MsysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 20:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ren-0001lT-HH
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 20:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968279Ab3HISnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 14:43:21 -0400
Received: from forward5.mail.yandex.net ([77.88.46.21]:42940 "EHLO
	forward5.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967943Ab3HISnV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 14:43:21 -0400
Received: from webcorp2d.yandex-team.ru (webcorp2d.yandex-team.ru [77.88.47.170])
	by forward5.mail.yandex.net (Yandex) with ESMTP id 0D1C21201B3B;
	Fri,  9 Aug 2013 22:43:18 +0400 (MSK)
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
	by webcorp2d.yandex-team.ru (Yandex) with ESMTP id E46D330F3C2;
	Fri,  9 Aug 2013 22:43:18 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1376073798;
	bh=5RHvv19v57Pj7kA/OsGv4KrefTFm5KmojtZRz7detyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GXbCLcecPx8uElpG7pDPeGSNHILmUyWXGVYl7NSET2jNWd51vPYew6aUoK/rTs/n/
	 xBkWnlwgZCmSb2EUp+EkiVLtXZ15xUBHXiUVbeoEsWwOderefhZ37W+wzhX+Ww2div
	 gZ41ATfKg5oKae2spnYRTMuNc6SZpYvN2Hkhm9DQ=
Received: from dhcp-3-237-ben.yandex.net (dhcp-3-237-ben.yandex.net [77.88.3.237]) by webcorp2d.yandex-team.ru with HTTP;
	Fri, 09 Aug 2013 22:43:18 +0400
In-Reply-To: <FA03039F4A644EEE8CEEA25BCFDA1994@PhilipOakley>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232009>

Philip,

Yes, this is msysgit, version 1.8.3.
Now I switched back to 1.7.11 -- there is no such issue in this older v=
ersion.

09.08.2013, 22:31, "Philip Oakley" <philipoakley@iee.org>:
> From: "Dmitry Kuzminov" <dkuzminov@yandex-team.ru>
>
> Dmitry,
> The Git for Windows development list is at msysgit@googlegroups.com.
>
> Is this "git for Windows" or one of the other git versions on windows=
,
> and their installers?
>
>> =9AThere is a standard command prompt icon in taskbar for GIT Bash
>> =9Ainstead of GIT icon
>>
>> =9ASteps to reproduce:
>> =9ASelect Taskbar Properties, Taskbar buttons, set to "Never combine=
"
>> =9ARun GIT Bash
>>
>> =9ABest regards,
>> =9ADmitry Kuzminov
>> =9A--
