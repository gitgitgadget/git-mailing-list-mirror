Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70034C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 10:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJGK1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 06:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJGK1K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 06:27:10 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8B79E688
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 03:27:09 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id o21so10279106ejm.11
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 03:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbY+06WDiTA+enKzC6v50Hmhv8rDRuqHTja0UyoxyjE=;
        b=fH8BWUGdrBm1NCnVtbp8fzoBVC6bqtyGZcly2McABze8qLaitHXcVkn4wiWff0mpKO
         fE7tvimsdPLM2Xd+QKZhtG2fhJKZ2HtP1DuKF41hywaZbVn27JEzlLmyxiNAkOg7bVwa
         IK/HSBdgixoJMuDtptAnXYwKDF9K6RmHePPgzECtErXEYC8xC9JVvVYiZXeVQPCuD89G
         4EUqVQT8Fl0MjKHeMfhrGCNnXO+Pi9J3iyFhcuh9OZy0kXMR9rnmuEeMQNPXoVN0YUF7
         4c95M3CMgZJf1yPuBr1Gowj3fgQlTKyFeQsifL7dut9bbgc23msVJXNTGMRXERG9AbWK
         x0Ig==
X-Gm-Message-State: ACrzQf35TOvvVnuEkkYMRQzOvILJqTyN1pPpWYvA+oEnv23Ogp5+AoPN
        3sJ0LudfXlkYxh3UFYsU3IVmx+zygfGifXgO/Ks7fad+qQc=
X-Google-Smtp-Source: AMsMyM4R/m53BTRkrJyoioaUwfqXtgRtpVa+Gs3fbRTut6dJOeKvNAGLbTUFAv84RMEz4+AEUvQEGiq7s8DpTMI8gEI=
X-Received: by 2002:a17:907:968e:b0:78d:580:eb2e with SMTP id
 hd14-20020a170907968e00b0078d0580eb2emr3528783ejc.235.1665138427801; Fri, 07
 Oct 2022 03:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
 <CA+JQ7M9082jsYsVtRCocAkXU5-C-=gs3vOvgP8G3CKbyz872KQ@mail.gmail.com> <CAApTLm9ME2GAvqa2+F7ZL8oLjOEdYPrgC2hP3uZLdypP-1fxAQ@mail.gmail.com>
In-Reply-To: <CAApTLm9ME2GAvqa2+F7ZL8oLjOEdYPrgC2hP3uZLdypP-1fxAQ@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 7 Oct 2022 12:26:31 +0200
Message-ID: <CA+JQ7M-rdFomPh106KFFCgEdHPKNTQZTUZz7Vu1Hx5GKdtY7qA@mail.gmail.com>
Subject: Re: A possibly mistake on the "Git Commands - Setup and Config page"
To:     ddady <ddady1@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2022 at 11:45 AM ddady <ddady1@gmail.com> wrote:
> On Fri, Oct 7, 2022 at 10:13 AM Erik Cervin Edin <erik@cervined.in> wrote:
> >
> > On Fri, Oct 7, 2022 at 8:12 AM ddady <ddady1@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > If i'm not mistaken, the path of configuring Notepad++ as default text
> > > editor 64 bit version is: "C:\ProgramFiles\Notepad++\notepad++.exe"
> >
> > Can confirm this seems to be the default path for the 64-bit installer
> I didn't quite understand. It was a question?

No I mean that I can confirm that this seems to be the default path
