Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFEA21F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 16:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbdAZQGV (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 11:06:21 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:36184 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbdAZQGG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 11:06:06 -0500
Received: by mail-it0-f42.google.com with SMTP id c7so131840681itd.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4Au3r1CnlpkVG/sCCx5+tJ461dtZ6LpmrB57FlFYGVc=;
        b=oMufrHpV2IkEgdN1zyx2SUCV3sF9jnS2cQEPN/4Z/NGxUhUoSmvnyTdqqKrDdm7+EF
         ZZqyRVqsW8MaqDUtIx9YO1/1qMZ5qvcqB0hfP4sEHum6WPXpWGU0cCNuog9pPIW10yVk
         Vd8fcksLK+4eGVggx7bNqK6tcIPrdMhTdrKtHFNa8Gfru7cZWkM8+sOOBj1tVQj0Ybg3
         dwQsjTTpYmRS3Yw1UrGZ1SGhHJVOfsx8pxmPyfPo9+pviRdJsv+q0BbJTuCS/YTVKz1K
         iLzpt9jboggqECDyuOcvu6vI0F3N2QYL8Lm2uFabMr5WV1tcIagt8AtaSphPWeMmUFvF
         +8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4Au3r1CnlpkVG/sCCx5+tJ461dtZ6LpmrB57FlFYGVc=;
        b=pFG4T127pVT/yYnkrpE2DqkRMYsl0rYiS3hbvUCs8FgiQ0BXFgsAAqouSP9TIhGdPx
         X6q+T4/QqRhugt0A6dKqYF09cZBF8Fne2mPWTWw0IkXsVzD0QRWZGCQbFh1yGplirzZu
         r/4hdknjOkyBbK6pPfBxTeRk3K34IFoeKQ/7wjO1kg5bZVWlDCyjkkwag6LbW5+TkPkd
         kU4YQT+J4teTi6Ic3dekLKV/5GBTtbog8Dp8J/xeeyzCvb6Lcal9JfdR1kjfsJPzg9w7
         WHFLw9Dleysng3naxXblMZQPEQDyR5NTGAYgG5+NUAU08EsS8w+0Fs1zE0TEW3r4fPrI
         MgYQ==
X-Gm-Message-State: AIkVDXLn+l0dL8JeUXUqTKI+XZaYSzTJkNz2Qd4bi/rnLUfNbfhd+7Ra7XLnVMxZ1BQLvTjX57xFgkvnXSaeXA==
X-Received: by 10.36.53.78 with SMTP id k75mr30290354ita.45.1485446278951;
 Thu, 26 Jan 2017 07:57:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Thu, 26 Jan 2017 07:57:58 -0800 (PST)
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Thu, 26 Jan 2017 21:27:58 +0530
Message-ID: <CAFZEwPM8UW2sYJwEPPY=L8Z_3TZhGFJZtiBA6g4XBDe1bi_JHg@mail.gmail.com>
Subject: SoC Microprojects 2017
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

I helped in just re-organizing the micro project list for 2017. I have
removed the ones which I remember have been done and I have added one
new.

Please add any microproject if it comes to your mind or reply here so
I will add it.

Unfortunately, I can't send the patch here (SMTP blocked by institute
proxy) but I have included it as a link[1]. And here is the PR[2].

[1]: https://patch-diff.githubusercontent.com/raw/git/git.github.io/pull/219.patch
[2]: https://github.com/git/git.github.io/pull/219

Regards,
Pranit Bauva
