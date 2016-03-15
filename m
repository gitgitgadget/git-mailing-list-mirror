From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.7.3
Date: Tue, 15 Mar 2016 13:19:20 -0700
Message-ID: <CAPc5daVDBcFr_ijEAj2-mZsP5Yj3O_Yynff3fDibsjBTEVwFGA@mail.gmail.com>
References: <alpine.DEB.2.20.1603152117350.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-for-windows@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 21:19:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afvRS-0007r1-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 21:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934918AbcCOUTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 16:19:42 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34494 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933176AbcCOUTl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 16:19:41 -0400
Received: by mail-yw0-f171.google.com with SMTP id h129so36065355ywb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cgAITZRLnjbCBmHK7Q1DjkcFq4yhO+HjAqRHUsc9w2M=;
        b=GZDO966kD/sH+KvvDTXsJlf4LmRvvY3sw9ul6bv3ILi1FTki8YpubkLgKT5zMEm1q2
         +Kh2Lpn1b9QkZDSJOSCNAFgj1kjti0u3eq/KIcXjPpaws6gSN2B2rwZJk9XEkyr+v2SP
         9y9UWG+BzNGUXWSMvDFhhn4b5EUIT8bQPupbQQc7hOIEMAKGGowvZb4xOPoP93Rp6JCZ
         2OMYU+2oKz/jn8Pz6wF835wxcezgRZUNeiVNtm4r5ODGjsUWhC3OEU/cA/Fdjntn3MS9
         MkdyYDNucbw01iK94emr9KeTXMSdpe2i87pLcBEQV55slZNwxt2PdzrB4iTuBCNsWTYf
         Af0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cgAITZRLnjbCBmHK7Q1DjkcFq4yhO+HjAqRHUsc9w2M=;
        b=hv8vJeyXLqa/wmtPdtYky0YehBB+MnvMlkL73kptZz7vUKBHDGLTojMXKC/KaRjcM7
         hxO+VqlEtRqgLuM4RWyW8NYJa7V2WFiFMsRDyGVsvDL8bpLQD1Zyi4+QzHXvc0U529Dg
         P4PnbPAcZc6AYzXtDMJLEXGMuDOuU5CBJK6Sxfbe7XCYEU/Pg/POnJ+NIB7HtMy80Ogv
         mTmCEUiV59PCSqzh1Tug4NEpSAkF9p3mSihuUoyhxHwKanQqB4uafdxWJ/C+ze4dM4re
         1yM4wR6tE8PpwlYJx6D/GlpqsgWj4vbBaQxfqpKdJAcLL4mrbBG3k3EZ714mVi7gBC37
         qa+g==
X-Gm-Message-State: AD7BkJJdhDoWgwQXSr7C3ZELD5mzb6wxW+IZby/1Ezn4MEmaPQXS9HQW0HWYE3eSvm576MhKYfebrOVR3gw5iw==
X-Received: by 10.37.230.70 with SMTP id d67mr17156661ybh.123.1458073180350;
 Tue, 15 Mar 2016 13:19:40 -0700 (PDT)
Received: by 10.129.116.131 with HTTP; Tue, 15 Mar 2016 13:19:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603152117350.4690@virtualbox>
X-Google-Sender-Auth: vn_i15i9sIL62SGD7RL6Mfk_sD4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288908>

Thanks.

On Tue, Mar 15, 2016 at 1:17 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Dear Git users,
>
> It is my pleasure to announce that Git for Windows 2.7.3 is available=
 from:
>
>         https://git-for-windows.github.io/
>
> Changes since Git for Windows v2.7.2 (February 23rd 2016)
>
> New Features
>
>   =E2=80=A2 Git for Windows now ships with the Git Credential Manager=
 for
>     Windows.
>
> Bug Fixes
>
>   =E2=80=A2 We now handle UTF-8 merge and squash messages correctly i=
n Git GUI.
>   =E2=80=A2 When trying to modify a repository config outside of any =
Git
>     worktree, git config no longer creates a .git/ directory but prin=
ts
>     an appropriate error message instead.
>   =E2=80=A2 A new version of Git for Windows' SDK was released.
>   =E2=80=A2 We no longer show asterisks when reading the username for
>     credentials.
>
> Filename | SHA-256 -------- | ------- Git-2.7.3-64-bit.exe |
> 382d30d38b5c88690864bb46be0a9c5f53b7046e7a6485dbcede602c41cae9a2
> Git-2.7.3-32-bit.exe |
> e38ddcc2c17390ffec0ca4d5c4fb948b5b4874ea0c522d5180cf2ee7e63f76bd
> PortableGit-2.7.3-64-bit.7z.exe |
> f5b39244869efcfac57c9a9f1d75119de0121bc8aa260d1824dfe5902f9a3f60
> PortableGit-2.7.3-32-bit.7z.exe |
> 82df6b1e8ca8550d7267641e32c6b736f0687e35dc3b772b21914706f13cdea4
> Git-2.7.3-64-bit.tar.bz2 |
> dd81fe03c83e255382816a5db1427b284288fe21b4f89cbe3b1ff21af8d0ef1c
> Git-2.7.3-32-bit.tar.bz2 |
> 3b845331cf91e2a1677ba959d07491c6b04b8bdfc7900236a201d0f8c9863197
