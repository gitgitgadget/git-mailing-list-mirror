Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F751F403
	for <e@80x24.org>; Sun, 17 Jun 2018 03:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbeFQDZz (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 23:25:55 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46415 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754082AbeFQDZy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 23:25:54 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so4616268ywc.13
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 20:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Z/aD59SbnOmcEG3TUuIzUV12XySzNaPSHxifFioumk=;
        b=aFn9qk4KVyYknsr19OvEXjoadlCuo+Iojdd+4f+ietcdmzXSO4Ho6qZmqGP9rmZzoB
         uXzplr28mzgDN2XQ8ijqCpxhcEZhTR8l8bBWIWucVp7kbhHto59fJc+iD5M43OvV93NK
         c9c1pi1kwZIyOB7xOwds8Adf9XFWYqI34V7Zo/O9HIobEFRdk78iQDiTi/D9yXe8DSBE
         tsdhoNH/dfWe4xhB+ntaDqG2snyyUiiuROYzG1m9I+Zz6EXt4uKwoJLZNidM+miHgxuw
         CL8k7Z4PPo9AAc4W92YghSdPVjU6BU96xdD3wUnb8hdie8SIUcEfGfFrG8DTdtHH6Nv3
         e35g==
X-Gm-Message-State: APt69E2crPenq0M+kPEB3T3fNc2Thag+1cTg8ORHFh2GXl4Ayg5hPoY5
        RuASNhG9euzuwFJZWBel9tQPLDHE4dbeQ1XU5qU=
X-Google-Smtp-Source: ADUXVKLQ18ek72KsHEkLDwViVvv0INCHRWNaLPx7GtPo0mKeAfY9DiJojlKjHrPHgcvZXKPlS3h3ksDVZ7O3K7E26kI=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr3631256ywa.16.1529205953903;
 Sat, 16 Jun 2018 20:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <0102016409c877f9-58c13d7c-4d25-43e2-8d64-c13d98b88ee7-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016409c877f9-58c13d7c-4d25-43e2-8d64-c13d98b88ee7-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Jun 2018 23:25:43 -0400
Message-ID: <CAPig+cTJMNw9JhqCQtqqU+MV7rzfy_yEQ_WuNaBdo-VVZf-9LQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typos in documentation and release notes
To:     tir.karthi@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 16, 2018 at 2:08 PM Xtreak <tir.karthi@gmail.com> wrote:
> doc: fix typos in documentation and release notes

Thanks for the patch. All the fixes look "obviously correct".

Please sign-off[1] your patch so it can be included in the project.

[1]: https://github.com/git/git/blob/v2.8.1/Documentation/SubmittingPatches#L234-L286
