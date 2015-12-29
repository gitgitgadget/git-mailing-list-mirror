From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] l10n: de.po: translate 68 new messages
Date: Tue, 29 Dec 2015 19:17:56 +0100
Message-ID: <CAN0XMOJgudTQQrU032OtTD-CbOipKRg_x8oUSyCWCN0mHtMFbA@mail.gmail.com>
References: <567D9577.9050809@gmail.com>
	<1451072298-5412-1-git-send-email-ralf.thielow@gmail.com>
	<56818E42.5010508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phillip Sz <phillip.szelat@gmail.com>, git <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Magnus G <magnus.goerlitz@googlemail.com>
To: =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 19:18:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDyqP-0004hd-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 19:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbbL2SR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 13:17:59 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34204 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbbL2SR5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2015 13:17:57 -0500
Received: by mail-lf0-f66.google.com with SMTP id n70so4452789lfn.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LK4HhGckHyDU8gph9ycxGcNTJJC1f8G9FP7Ooq8wU8I=;
        b=iJ1FSh37PfLOtatMUE301aGMax3HLuhIKMMcDBet9/Rn9NN0D3ZWGZu9fJ7wIoKVgd
         5XSFf4Gy7Gz9zruivqif+gnwxK6kmZ+kSQ3P0F5e9uFHfninzqWuNWLg07DZDRDv3ljL
         CWu16zFTReowNLfK0a8FTH3CCtjF1HJ033rFk4AHkWRBelXJJH8RUho4go9zFCkKv6Al
         IEzK3xCZFUfFtQR95U0FW9HKkQEKF/I1NfNm7uFusw1Y6z60bobTSin1heYzQ5gx2kh7
         Cz+E9BBq8l3VAE/FJnmP5nySefYCeCPDzfrjhjFM5kUXpv4OK7d2ptzrdIfxrU2mgnl/
         eJTw==
X-Received: by 10.25.15.12 with SMTP id e12mr8278254lfi.82.1451413076374; Tue,
 29 Dec 2015 10:17:56 -0800 (PST)
Received: by 10.25.152.18 with HTTP; Tue, 29 Dec 2015 10:17:56 -0800 (PST)
In-Reply-To: <56818E42.5010508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283136>

2015-12-28 20:32 GMT+01:00 Matthias R=C3=BCster <matthias.ruester@gmail=
=2Ecom>:
> Hi Ralf,
>
>>   #: builtin/submodule--helper.c:273
>>   msgid "fatal: submodule--helper subcommand must be called with a
>> subcommand"
>> -msgstr ""
>> +msgstr "fatal: submodule-helper muss mit einem Unterkommando aufger=
ufen
>> werden"
>>
>>   #: builtin/submodule--helper.c:280
>>   #, c-format
>>   msgid "fatal: '%s' is not a valid submodule--helper subcommand"
>> -msgstr ""
>> +msgstr "fatal: '%s' ist kein g=C3=BCltiges Unterkommando von submod=
ule-helper"
>
>
> submodule--helper (at both lines: one minus sign is missing)
>
> Everything else looks great!
>
> Acked-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>
>

Thanks!

>
> Kind regards,
> Matthias
