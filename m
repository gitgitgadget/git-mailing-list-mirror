Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54885C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 23:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhL2XQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 18:16:41 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:51067 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhL2XQl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 18:16:41 -0500
Date:   Wed, 29 Dec 2021 23:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640819798;
        bh=ZiuoVP6EemIZ2Gm1YjhnsP0LMaUh77tIqjVkuGn9mSk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=HPJqT5x4RzCmjqx/KPDnh6Ijhs/BrgQvFMHMQIGZ9nH7lUfhOs9q7ZFAjMVI5yU6L
         HMI1rZkK193FAweUqKqbNzPzdNt6wUTvZA77Rg8Mv3/RsMUsHlBiU/s/RSytDgRkzS
         kvyWiPM3kw6JNsiTaNrpMvujHrflPl3XZZsbtFDdxhE1IlQKD58D49jegL7sPe2yWH
         c0+75WP34n7lGvJzu/h/KaD993hXBbcd72gMLhwgGZEBMLeS+WK+3c8+wdYKRGtjBp
         jdcbZX80wrABPKK0XS19sRy2sNcQGBHd3ALGV5vZAc9nKsqiayf9is74gpHcdGaUV5
         UEKzGL0KuuqUQ==
To:     Philip Oakley <philipoakley@iee.email>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Lemuria <nekadek457@gmail.com>, git@vger.kernel.org
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Git internal command line parser
Message-ID: <M6HMTm0dtIrBEIowkbx-CyuDyS2IXUt1CwYei4z0pBdkWvGqK9bZr2ZVWt---Yy2PudrsoPMw7cNe3B0a4ZbV7Ruujdkqpi882Gp7jUXLUQ=@protonmail.com>
In-Reply-To: <456ef68c-dd01-e781-6ff1-e351c39671f1@iee.email>
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com> <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email> <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com> <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email> <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com> <456ef68c-dd01-e781-6ff1-e351c39671f1@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This (over simplified) explanation relates to the differences between
> the OS approaches to the performance issues when creating new processes
> and the like on Windows. Each OS has strengths and weaknesses.

Oakley, to whom did you want to address this and what did you want to say?
I don't get what you meant.
