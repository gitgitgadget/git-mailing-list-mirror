From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull l10n updates for 1.8.4 round 1
Date: Sat, 3 Aug 2013 15:14:38 +0800
Message-ID: <CANYiYbFLOTk24SJFb9dmR6wT+xG_7+PXU3B928PM0tfy4ua6dA@mail.gmail.com>
References: <CANYiYbHb7VLuf4PG+CW3aKyt2nyMPuf4AgaZmmc40nX2ggRK8g@mail.gmail.com>
	<51FCA8D9.1080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 09:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5W3K-0002PZ-U3
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 09:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab3HCHOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 03:14:41 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:56081 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab3HCHOk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 03:14:40 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so1161138wes.31
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1HCsFRo7200fAOMyThBrFKoJo2vPaBO2x689Ke3N+qc=;
        b=I4KAiTGHv3ql0dbt00xnEDJ6fr8EWf29VUrTDlbB5b5JHpd5FHrIwoBGsJ993kVv9l
         ZaKEMSdDjsXPw4y2ya79wsUmO0O9h+BFSdRBAcxFmuYPJB4yp5TdJ5fwGOdW4Rd/krAO
         cEl/iQ4x1g4hRqqY3C7XgbHhSSvw1xj1Ah+ccwq4XDAE9Wc7zMgk7wJFRKck/MXNJXax
         kNN2f8c75fwPsCX5KCXCJSxVx2jWVcNsvwJRodjHx7wccJiHE7xaJvdBld9o7+ZeJSYY
         HQZjLEXyE7OlbooQmieDi+k2K+/EflE5YkVyRGh4VxSf8QQiWoEmi9QhYZv3EPer6XVu
         MSJw==
X-Received: by 10.180.94.69 with SMTP id da5mr1127417wib.3.1375514078579; Sat,
 03 Aug 2013 00:14:38 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Sat, 3 Aug 2013 00:14:38 -0700 (PDT)
In-Reply-To: <51FCA8D9.1080804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231567>

2013/8/3 Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>:
> On 03/08/2013 13:39, Jiang Xin wrote:
>>
>> Hi, Junio
>>
>> Please pull these updates for git l10n.
>>
>> BTW, Ralf's updates for de.po are still in the review process in thi=
s
>> list,
>> but I want to send this pull request earlier, because I find there a=
re
>> some
>> new l10n changes (5 new/modified messages) in v1.8.4-rc1. I will sta=
rt
>> git 1.8,4 l10n rnd 2 right after gitster closes this pull request.
>>
>> The following changes since commit
>> c490a6079021a3343ca5b042b37258858fdefbfc:
>>
>>    Git 1.8.4-rc0 (2013-07-24 19:29:07 -0700)
>>
>> are available in the git repository at:
>>
>>    git://github.com/gotgit/git-po
>
>
> git://github.com/git-l10n/git-po
>

Thanks Tr=E1=BA=A7n. Should be git-l10n/got-po, and gotgit/git-po does =
not exist.

>
>>
>> for you to fetch changes up to 2e8451e8602380a8a129f21da6364f3ea879e=
6a9:
>>
>>    l10n: zh_CN.po: translate 99 messages (2133t0f0u) (2013-08-03 14:=
14:07
>> +0800)
>>
>> ----------------------------------------------------------------
>> Jiang Xin (2):
>>        l10n: git.pot: v1.8.4 round 1 (99 new, 46 removed)
>>        l10n: zh_CN.po: translate 99 messages (2133t0f0u)
>>
>> Tran Ngoc Quan (1):
>>        l10n: vi.po (2133t)
>>
>>   po/git.pot  | 3072 +++++++++++++++++++++++++++++------------------=
------
>>   po/vi.po    | 3383
>> +++++++++++++++++++++++++++++++++--------------------------
>>   po/zh_CN.po | 3300
>> ++++++++++++++++++++++++++++++++-------------------------
>>   3 files changed, 5403 insertions(+), 4352 deletions(-)
>>
>> --
>> Jiang Xin
>
>
>
> --
> Thanks,
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n
>



--=20
=E8=92=8B=E9=91=AB

=E5=8C=97=E4=BA=AC=E7=BE=A4=E8=8B=B1=E6=B1=87=E4=BF=A1=E6=81=AF=E6=8A=80=
=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: worldhello.net@gmail.com
=E7=BD=91=E5=9D=80: http://www.ossxp.com/
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 18601196889
