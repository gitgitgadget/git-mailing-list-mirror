From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull l10n updates for 1.8.1 round 2
Date: Fri, 7 Dec 2012 17:41:35 +0800
Message-ID: <CANYiYbG2momfyvSj6fFd3tTnzQq_5ivUGcJTEESPcgH=p59pDA@mail.gmail.com>
References: <CANYiYbGG8DeneCRyxyfVoZ+O2yBm9ywOGZwQMZC9=VYVN5Pf=A@mail.gmail.com>
	<alpine.DEB.2.00.1212061249040.25550@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	=?ISO-8859-1?B?VHKlbiBOZ/djIFF14m4=?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 10:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TguYE-0004TP-B4
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 10:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783Ab2LGJsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2012 04:48:41 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:36000 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab2LGJsj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2012 04:48:39 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2012 04:48:39 EST
Received: by mail-ia0-f175.google.com with SMTP id z3so258618iad.34
        for <git@vger.kernel.org>; Fri, 07 Dec 2012 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=A8tAMIgiMYB/afyhOY6HVppAmT/oYLi4xS9gRcz2cQw=;
        b=ByShZ+Gjegcs0IZtvlxomTrMhoQ+PpnNN0C+wyoKkrRt9N2547a6JSflI2W9VtMM3c
         JrPhLMGQvjMUijDXjFIR/mpuCGerJMG7zdShuiAWxB9wtKOUDw8LBmf7kxEIjuiwIqDt
         msiqanQZwKek+lOXe4NALg++2DlOnvKXO/D4HCfuSFSitIHjtxPQSznKIii3kHGSLreY
         kkL84kNtXeEFIPO7NiyRFLRj/BQrktUCsB+3y0/RNvTXhudpv+l2LpfAHdb72PPi0lDa
         qLK5vi2IOccnz/EoMh4Zji3tQaRbSkkPvVrLMf+gnZ7rfnUMskPH/M8LQeEyyqqUXFu0
         X4mA==
Received: by 10.50.189.193 with SMTP id gk1mr4516803igc.22.1354873295489; Fri,
 07 Dec 2012 01:41:35 -0800 (PST)
Received: by 10.50.186.135 with HTTP; Fri, 7 Dec 2012 01:41:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212061249040.25550@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211174>

oops, I missed Peter's email, and the following pull request includes
both Peter and Ralf commits.


The following changes since commit f94c3251e1400c3cf349f7f84fea4db66b54=
0113:

  Update draft release notes to 1.8.1 (2012-11-29 13:57:09 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 167e2f91150304ed1f7b24659101aae19c01e30d=
:

  Merge branch git://github.com/ralfth/git-po-de (2012-12-07 17:30:02 +=
0800)

----------------------------------------------------------------

Jiang Xin (2):
      l10n: Update git.pot (5 new, 1 removed messages)
      Merge branch git://github.com/ralfth/git-po-de

Peter Krefting (1):
      l10n: Update Swedish translation (1979t0f0u)

Ralf Thielow (2):
      l10n: de.po: translate 825 new messages
      l10n: de.po: translate 22 new messages

Tran Ngoc Quan (1):
      l10n: vi.po: update to git-v1.8.0.1-347-gf94c3

 po/de.po   | 5157 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
--------
 po/git.pot |   46 +-
 po/sv.po   |   53 +-
 po/vi.po   |   63 +-
 4 files changed, 4466 insertions(+), 853 deletions(-)


2012/12/6 Peter Krefting <peter@softwolves.pp.se>:
> Jiang Xin:
>
>
>> The following changes since commit
>> f94c3251e1400c3cf349f7f84fea4db66b540113:
>>
>>  Update draft release notes to 1.8.1 (2012-11-29 13:57:09 -0800)
>>
>> are available in the git repository at:
>>
>>  git://github.com/git-l10n/git-po master
>>
>> for you to fetch changes up to 77cc392d6d60c5d22930174904adae182502b=
8a9:
>>
>>  l10n: vi.po: update to git-v1.8.0.1-347-gf94c3 (2012-11-30 13:43:11
>> +0700)
>
>
> This doesn't seem to contain the update to the Swedish translation th=
at I
> committed in https://github.com/nafmo/git-l10n-sv (commit
> bf3e8fe0c718b64b7e88bd3d74564c54f923aaed). Did I forgot to post a pul=
l
> request to you, or what happened?
>
> --
> \\// Peter - http://www.softwolves.pp.se/



--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 010-51262007, 18601196889
