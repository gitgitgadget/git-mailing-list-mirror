Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5209C433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 02:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhLZCiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 21:38:22 -0500
Received: from mail-4325.protonmail.ch ([185.70.43.25]:10803 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLZCiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 21:38:22 -0500
Date:   Sun, 26 Dec 2021 02:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640486300;
        bh=4OYcR37PLvvOa3KMWekZhurIMMaPGhBmwg2s58bbyLs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=IBbpSyBsrsizYMVN/yz9M6VKamV4UQf1J1GP0P6GYhKN3/NHd4Y2U4a+5EC9iYqUt
         fNEXk1w7nhIwrM0ndS6PKEU6htOp8FwWMQk2L2XqjOdXSb9CUkTmCoEG1a6U+YBmCt
         Q3cCM9ITuw0u2xJXX0qvmrvBWpWRE0Cdd5ygZiTNvs+IUrS33wyf5jTNL+8jGjrF9Y
         p509A3LvcEmPxsjtFFjAii64J1ng7Po4UwIQ6FpndDI9vurA4Mi7NHsODwD84hz97v
         I2VRScAvBLvgnmtl60uRfA7Wcg2CM2CGIBIKLVmSH4ldKWcamiGwRMnGqubOYyrGRZ
         QesUOIfTau2bQ==
To:     Lemuria <nekadek457@gmail.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     git@vger.kernel.org
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Git internal command line parser
Message-ID: <-WF_iHKAhyH3NM_qOg4GeWV-KnDZbiUTF700TOojIuYKduAfY4-Jl4NSmHNHoLjlixEeHH6JVAIEC03IBAQ7mBTdvlR87APri0yyM5tElOY=@protonmail.com>
In-Reply-To: <65fdfd25-736f-5105-6eba-b70cd51cc780@gmail.com>
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com> <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email> <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com> <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email> <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com> <65fdfd25-736f-5105-6eba-b70cd51cc780@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Saturday, 25, December, 2021, at 05:32, Lemuria <nekadek457@gmail.com> wrot=
e:
> Was this directed towards Lemuria (me)?

 Oh god no, those were more general comments about the way things are done =
on Git, rather than directed towards you. See it as me reacting to the info=
rmation received and trying to pull a conversation about it with Philip.

> Okay, I understand. I'll do everything to keep my code bias-free.
> I'm working on a project in C and if it's okay, I'll link you to
> the GitHub repository.
>
> I'm sure the git mailing list isn't the right place for me to get
> criticism on that project however.

 I will do my best to help you out. If you want to contact me, send an e-ma=
il to my address (JoaoVictorBonfim@protonmail.com) and we can talk it out. =
From experience I learned that, when talking about prejudice, it is better =
to shut up, pay attention to the conversations in the room and see who is b=
eing denied their humanity, who has the power in the situation and who is t=
rying to prop up an emotional response from others. Most of the time, those=
 who are being denied their humanity, those who are restrained in their res=
ponse, those who have no power or say in the conversation and those who are=
 more emotional than trying to prop emotions are the marginalized in the co=
nversation.

Now, out of curiosity, are you named Lemuria because of Lemurs? You know, t=
he little primates from the Madagascar island?
