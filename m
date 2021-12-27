Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C6C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhL0QYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 11:24:10 -0500
Received: from mail-4325.protonmail.ch ([185.70.43.25]:49903 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhL0QYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 11:24:09 -0500
Date:   Mon, 27 Dec 2021 16:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640622248;
        bh=11YvC+Tkd6mghcMjJAN6jNCHtBo1lPp+OR6z/pB4BSA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=ENXafYtEa7wq1aowPfJU4vGnw3iHjnVC71mKKFEFiBqG5h0YNU0DTTURgeGKPNBTj
         SOeRVk/WTbcrFYRbKe+/tcsvyL1Y6cg9gBQ9cDvxuLExCgdjH5i+Z+ufai4I7xTqlR
         Qp3jYSwDuCCl5nGZgdZiSkxI/MR6v7bm/1ovltkQCqWscpoTjly941AOJNsNyccLnN
         7E65P+M2nqawZC4FbNiZb7rAHm43H5pt4MdoCVHGuwszOR4s+wB5T9081Adxj0DZ4g
         3bVFjPVvLMkBbyxiH4UR2NjFAfygLD5Fb8P/l+5TydbHWLGr/4yTBO172jMAiNzYOX
         T61AWluB7VuZg==
To:     rsbecker@nexbridge.com
From:   zhiyiren2009-subscription 
        <zhiyiren2009-subscription@protonmail.com>
Cc:     zhiyiren2009@protonmail.com, snakamoto1975@protonmail.com,
        git@vger.kernel.org
Reply-To: zhiyiren2009-subscription 
          <zhiyiren2009-subscription@protonmail.com>
Subject: RE: Quick login of git
Message-ID: <J-VncZqqtXGSpnkopiYEtOET-oeVZX1tk3jBX9c3oSaOrcH1N_ciDdzQFvk50CkibrWFCboQNDeegBNMGZ247duUXwnPFY_0HbFvEWI0hVg=@protonmail.com>
In-Reply-To: <004601d7fb3c$c9d359c0$5d7a0d40$@nexbridge.com>
References: <7w7c2MDOBpV9yIlD5yZZb801w-eaz0qhErkCN-De51h892xRFL14N-LCXH0O8wvDp_51A3hC86EMXonBkjNdoTZ-iy8xzoKLVecN6D6Zpq4=@protonmail.com> <004601d7fb3c$c9d359c0$5d7a0d40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Did you mean Multi-Factor Authentication=EF=BC=9F

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Tuesday, December 28th, 2021 at 00:14, <rsbecker@nexbridge.com> wrote:

> On December 27, 2021 11:07 AM zhiyiren2009-subscription wrote:
>
> > Why not add a quick login method like VSCode and CLion in git? Login to
> >
> > GitHub/ GitLab with one click, without privete key.
>
> I am not sure this has anything to do with git itself. One does not "logi=
n" to git. You might want to take this up with the GitHub/GitLab support fo=
rums. However, one-click login is being replace with MFA.
>
> --Randall
