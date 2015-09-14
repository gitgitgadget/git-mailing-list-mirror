From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 123 new messages
Date: Mon, 14 Sep 2015 19:09:31 +0200
Message-ID: <CAN0XMO+gAvOEgd4gsQrEnUef1vpz+oqeWEn7RcWUJsN=bJ_82Q@mail.gmail.com>
References: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
	<55F5C1F6.8000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:09:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXG6-0007ba-V0
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbbINRJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2015 13:09:34 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33057 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbINRJe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 13:09:34 -0400
Received: by lbcjc2 with SMTP id jc2so70978391lbc.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wk/q0oXqeKNYy1fD9a7Z7GMxMSzDZVoMXBnX+UVyki4=;
        b=Uy/KjWdrTfOw1M9hS7ZECL2NTtEGYH3SWRR7Csb+TpuYgUYKnmdtGGdFAUJBjGkjIe
         XOZ44C1RcMJARlasa5X/Z0nUm33aNQPnBmXWzIBAvvmKhMORwLytCYE2oe9iUys9TlbJ
         s5LDNRjPDjsX2wO4cxDCo4iBUhnwbrd8bkl+zddLM/ha33sFqxhRVJa/GuWRH+mHnoqx
         RzOzANxCnKskKdDs178f7ZOkcpJDtEpXTSU3Psenv1B5M9XNAPkNU2of8GED3NGBYO5c
         mzNRl9JHt+jEW75gd0J6TJTjJ6D1ZoZpSMQmFKIapXqZONZU7dxxQqgz+odHnoSZM3yV
         CoDA==
X-Received: by 10.112.157.40 with SMTP id wj8mr15652638lbb.64.1442250571445;
 Mon, 14 Sep 2015 10:09:31 -0700 (PDT)
Received: by 10.25.201.211 with HTTP; Mon, 14 Sep 2015 10:09:31 -0700 (PDT)
In-Reply-To: <55F5C1F6.8000808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277840>

Hi,

thanks for review!

Am 13. September 2015 um 20:35 schrieb Phillip Sz <phillip.szelat@gmail=
=2Ecom>:
>>  #: wt-status.c:1105
>> -#, fuzzy
>>  msgid "No commands done."
>> -msgstr "Keine Commits geparst."
>> +msgstr "Keine Kommandos ausgef=C3=BChrt."
>>
>
> Are you sure about this? "done" could also mean something like "erled=
igt".
>

I considered using "erledigt" but came to the conclusion that
"ausgef=C3=BChrt" (english: executed) is more suitable for saying
that a command is done.
