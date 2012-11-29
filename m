From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull l10n updates for 1.8.1 round 1
Date: Thu, 29 Nov 2012 17:40:32 +0800
Message-ID: <CANYiYbHu99J1DT9gaLNuMrbxYRH0-0xMKjBMrOK7V0xzcnU2SQ@mail.gmail.com>
References: <CANYiYbHfhBXbLEEKdpJkhp+wY9-AJ1JkjfO62W3c+dm8qpk7_g@mail.gmail.com>
	<50b70eb8.46c5440a.38b1.3f66@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 10:40:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te0c0-0005uc-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 10:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab2K2Jkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 04:40:36 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63148 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab2K2Jke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2012 04:40:34 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so11716473iea.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 01:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZeCKmvGi6zbQiA1cNN405T72sqnhWhgK57IoYf0XAdg=;
        b=ofi8Wlu0+TChBnLiZlvUym12kcBt9vZJVQSn2BdL0WAnH1AkSwV2rqWzpbN0qICLkp
         lBmBSyllfeK03ncolmk6rL4+qnxaD7Dje/p2uHwDhYfHHy10MoZ8Q4MrsuCLf+7wVBCD
         eZjkAuuVN0EwDP7XH94OBmbI3VYl15NXphDqdtG5q9xZzjY1yv8Kv0Up4AgGbTJMhRWk
         +6v6WouoVSAmlmLL84PLT1Vp3514KFHPAjgZ+EtVoU1VFfc4p/4+L1Q7XFzlURNeH2Z+
         JO0HK/fLFtUqPxp62oI4FXXtHZu5GmObJWVteHQdpKIep6/jUB5OgOsgt08uTnIsqFQg
         7jeA==
Received: by 10.50.189.193 with SMTP id gk1mr22594365igc.22.1354182033109;
 Thu, 29 Nov 2012 01:40:33 -0800 (PST)
Received: by 10.50.186.135 with HTTP; Thu, 29 Nov 2012 01:40:32 -0800 (PST)
In-Reply-To: <50b70eb8.46c5440a.38b1.3f66@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210825>

Hi,

New pull request with updates on Vietnamese for git 1.8.1 from Tran:


The following changes since commit 2d242fb3fc19fc9ba046accdd9210be8b991=
3f64:

  Update draft release notes for 1.8.1 (2012-11-21 13:32:58 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to f93483ac94c21660422a19175f67cd3f8e87c531=
:

  Merge git://github.com/vnwildman/git (2012-11-29 16:25:40 +0800)

----------------------------------------------------------------

Jiang Xin (2):
      l10n: Update git.pot (14 new, 3 removed messages)
      Merge git://github.com/vnwildman/git

Peter Krefting (1):
      l10n: Update Swedish translation (1975t0f0u)

Tran Ngoc Quan (2):
      l10n: vi.po: update to git-v1.7.12-437-g1084f
      l10n: vi.po: Update follow git-v1.8.0-273-g2d242

 po/git.pot | 1224 ++++++++++++++++++++------------------
 po/sv.po   | 1246 ++++++++++++++++++++------------------
 po/vi.po   | 1951 +++++++++++++++++++++++++++++++---------------------=
--------
 3 files changed, 2305 insertions(+), 2116 deletions(-)



2012/11/29 Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>:
> Hello JX,
> You missing pull from my repo (2 commits instead of one, v1.7 and v1.=
8): dcc52a0449c7ee10690e23152e63b9798f8a332f
>
> $ git log -n 2
> commit dcc52a0449c7ee10690e23152e63b9798f8a332f
> Author: Tran Ngoc Quan <vnwildman@gmail.com>
> Date:   Sat Nov 24 07:37:35 2012 +0700
>
>     l10n: vi.po: Update follow git-v1.8.0-273-g2d242
>
>     Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>
>
> commit 131fa518f10521b4a534863331decbfef2875f24
> Author: Tran Ngoc Quan <vnwildman@gmail.com>
> Date:   Wed Oct 31 08:19:59 2012 +0700
>
>     l10n: vi.po: update to git-v1.7.12-437-g1084f
>
>      * updated all new messages (1967t0f0u)
>      * make quote become more good-looking
>
>     Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>
>
>  https://github.com/vnwildman/git.git master
> Thanks,
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n
>
> -----Original Message-----
> From: Jiang Xin [mailto:worldhello.net@gmail.com]
> Sent: Thursday, November 29, 2012 8:19 AM
> To: Junio C Hamano
> Cc: Git List; Peter Krefting; Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n; Ng=
uy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
> Subject: Please pull l10n updates for 1.8.1 round 1
>
> Hi, Junio
>
> The following changes since commit 2d242fb3fc19fc9ba046accdd9210be8b9=
913f64:
>
>   Update draft release notes for 1.8.1 (2012-11-21 13:32:58 -0800)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po.git master
>
> for you to fetch changes up to 647d5183b8dc36b38d19c7a3f388108f245b11=
d3:
>
>   l10n: Update Swedish translation (1975t0f0u) (2012-11-23 08:59:11 +=
0100)
>
> ----------------------------------------------------------------
> Jiang Xin (1):
>       l10n: Update git.pot (14 new, 3 removed messages)
>
> Peter Krefting (1):
>       l10n: Update Swedish translation (1975t0f0u)
>
> Tran Ngoc Quan (1):
>       l10n: vi.po: update to git-v1.7.12-437-g1084f
>
>  po/git.pot | 1224 ++++++++++++++++++++++++----------------------
>  po/sv.po   | 1246 +++++++++++++++++++++++++----------------------
>  po/vi.po   | 1597 ++++++++++++++++++++++++++++++--------------------=
----------
>  3 files changed, 2097 insertions(+), 1970 deletions(-)
>
> --
> Jiang Xin
>
