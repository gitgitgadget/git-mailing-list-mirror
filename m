Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBCB1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeI3W04 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 18:26:56 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:32984 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeI3W04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 18:26:56 -0400
Received: by mail-lf1-f43.google.com with SMTP id o21-v6so8117184lfe.0
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kFnNoPB2dSNCMq9pT2xnj0Uiz1IjOIyE0kTTiSyDLfA=;
        b=ZOl/eTPS+ikn02wtKSruJwiPOKYr8vQOUxqCTqXuzFzYUgA67cf66JLkCPuu/7I5o0
         BoYB7mhlF+V3nllAZR6k2R/lyxvvdGHQtnwIfVSJUn8V0zEjDpHpXnNAgqWNQyMehUZM
         0PuwW6qrHM8fNkOSJuZU3ZaQ9idlA2pB2pDoBgVU4mTOZXLmGXrlb/8iInwMVWl/6Yo5
         XJXEKAdm0XU4nHk4UFTifbWNNhvI7pr6fJnG9O+eksXUus2F8ZXgFsZ1kZr1oy6SjisT
         FyEH2x3z/rPYgNF18DXj+9CM2L1o+8nR53QeblbaYRtR1/2IuI6C7LIdL8EYV7TVY68X
         Xblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kFnNoPB2dSNCMq9pT2xnj0Uiz1IjOIyE0kTTiSyDLfA=;
        b=RCzC1deUfE7rwmD552PFR81RYgoGgnMPLHN2h+xzjWCoSsMG4wHr4TkuFaCB89fDoM
         pFsXGnMUH3JYItG/qshOXQDpHtUmDxahH0XSJXOgeT8nhLcMqKxBTPoxR/EAatXdgkKX
         5gMZFeZAgH6Ux9dWlBipFM2HBuQ+br2VpP3/hOEfP+9TgXhQ2H9Lxw8dE169jixBjCNI
         VOGRoBehqkTYaY17sI33kxzNyvTZQZQZwaAV8HUvyMrurkH48yJm7Zk0UW6PfgHp/DHk
         TqXTSvsEFh5erQitXxOhIWQcorDnoWeGnofRIn5OlbIfPClJ7s3FfYAX8UHEjIvc1vBV
         KvLA==
X-Gm-Message-State: ABuFfoh6ZEcqyCAgnSheED2suigPshkt678CbdV4HhQ8psP1Ry06eCLy
        M6QYUwx/y5J2TVHlzCldMAlCFWebbexDCEChfBdl6DhXZmo=
X-Google-Smtp-Source: ACcGV63g0FStSjCk4WApiTN5zpDKGBNe1AISn71PX9cGTN46/MtVEDEykO6GUQ4y6R9ivv8LzJVqEQVeWqIOJi98vo4=
X-Received: by 2002:a19:eadb:: with SMTP id y88-v6mr3364921lfi.1.1538322800911;
 Sun, 30 Sep 2018 08:53:20 -0700 (PDT)
MIME-Version: 1.0
From:   Ananya Krishna Maram <ananyakittu1997@gmail.com>
Date:   Sun, 30 Sep 2018 15:53:10 +0530
Message-ID: <CA+=o6KHC=wkJCK9g4aVdaw6CieXr3qFJTb1GHa48=vQaOdRh6g@mail.gmail.com>
Subject: [Outreachy] Introduce myself
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Community, Christian and Johannes,

My initial Outreachy got accepted. My name is Ananya Krishna(her), I
am from south India. I completed my under-graduation. Due to some
problems, I decided to stay back at home. And currently I would like
to dedicate myself to learn from open communities.

During the school, I showed keen interest in operating systems and
implemented most of the scheduling, synchronization and some sample
examples in memory management. I also did a lot of assignments in bash
scripting. In my 3rd year of Btech, I was introduced to this magical
tool `git` and got flattened by how it made me to keep track of
versions of my assignments. Having done a lot of assignment in C and
bash scripting and keen interest to learn about working of git
internals, I choose to contribute to this project. So I started
observing the patches sent to git mailing list.

I am currently looking for first patch opportunities to git. I came
across[1] and I will try to put maximum effort towards my goal and if
I need some clarification of the problem statement I guess you guys or
Outreachy mentors will be here to help me.

Thanks,
Ananya.


 [1](https://git.github.io/SoC-2018-Microprojects/)
