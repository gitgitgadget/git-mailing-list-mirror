Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87357207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 04:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbdDXED7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 00:03:59 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35897 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757822AbdDXEDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 00:03:16 -0400
Received: by mail-vk0-f54.google.com with SMTP id q78so32445981vke.3
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yk7cn5SMFTeN2N3WmBVVz3TEZ5IgsQ3/T8vKa6uHNQQ=;
        b=bzXdFsrZP4zCb2C8i3BHgiUF2YcEeS4rX15CKfCQa71nHQnkHH7bp4XkRWktFfOaZ1
         IWArGJWcm4oNVxEyW/6wQ9U4H4hSLzDEY9ma8ggcMJtcTG40xdkQ+itz6Qr2r2ZGyOPw
         il2xmtTZmKEHo0MR5S1OpkwmasA9FbQHwYftMfDVSUyRbx3q1AU2h0MdXvt4Qv0kSgvv
         t8oRdwMQRWwDZ35sWB1xyot1BPAiZ3V4bG3FwTUCPTix/XI18Gi2Ry1hqtLe9Fi5Odva
         ubqjUoXrfmYBosUltmcaUiuJQysEV4QezU3tfOww3GfcbYhq9WG8WSHisHczSlfO+Wjx
         2sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yk7cn5SMFTeN2N3WmBVVz3TEZ5IgsQ3/T8vKa6uHNQQ=;
        b=DpLsBsePBEifNp1L7b3MRdGHGwDYyOjM84cETnIAZFK+qTNaoZBx/8Mn2j+mTJ05Uy
         diVTUfJyM8Ueeza4TmTuGMedOyuS8ZwaMxFdNLHw9X2yioGXzLJPt5BAlWT7/EXheIyK
         ZKYID8+nNbcQ6YCO1auVtwERQ9u+QIVYP+HQNnsDyO1eywDj5koCWI1LJqSVGoFPgLoF
         p/A8HSa5oPIaGgjdWcwK4NZTzqMNwLNanDG2PwfnMdmlxAaT8gBwAPRhw4H0YR3+qDsq
         ZU+fKaApc6dKhGRWiyn8Myl1Cy3Nmk3qa6R+BkTd9xZVdF+z3xU5a7muk6Nb6yE2X7ST
         zeyA==
X-Gm-Message-State: AN3rC/6Ru7t6ZSw8qX0bK0dKN+HTOkek3wU9peijknaGgeJchOAJnyIZ
        /3O/d930VkX/gNNacArL6u89gltdRA==
X-Received: by 10.31.96.134 with SMTP id u128mr1865414vkb.124.1493006595215;
 Sun, 23 Apr 2017 21:03:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.105 with HTTP; Sun, 23 Apr 2017 21:02:34 -0700 (PDT)
In-Reply-To: <CAA0fXPu7s1-UQ-RBxvmPq0kGSsdt1wp9VJp7wNMZ_uE02RvCbw@mail.gmail.com>
References: <CAA0fXPu7s1-UQ-RBxvmPq0kGSsdt1wp9VJp7wNMZ_uE02RvCbw@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sun, 23 Apr 2017 23:02:34 -0500
Message-ID: <CAJZjrdVyKcPCmPT8S=Spju_Q7KRjkm7AbP4H--pVdiY9qR=AhQ@mail.gmail.com>
Subject: Re: I suggest a new feature: One copy from files
To:     Rm Beer <rmbeer2@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...what?

I'm sorry, I have absolutely no idea what you're asking. You're going
to have to be a lot more specific with your description of the desired
behavior because as is, I have no idea what purpose your .gitonecopy
or .gitonelog would serve. I also have no idea what this has to do
with the binary files ignored by .gitignore.

It would probably make sense for you to describe a use case for this
as well, to help us understand why you want what you're asking for.

On Sun, Apr 23, 2017 at 10:47 PM, Rm Beer <rmbeer2@gmail.com> wrote:
> I have a several directories with binary files datas that is discard
> by .gitignore.
>
> I recommend make a new .gitonecopy or .gitonelog or something that
> take the directories with only 1 copy of last updated and not take
> history of files in the repository.
> Maybe anyone found other best method for apply this idea.
