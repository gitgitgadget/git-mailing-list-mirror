Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8244120248
	for <e@80x24.org>; Thu, 21 Mar 2019 21:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfCUVok (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 17:44:40 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40645 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCUVok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 17:44:40 -0400
Received: by mail-pf1-f180.google.com with SMTP id c207so3590pfc.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=AUDZk6MjTqL+H7mCm4hIxTxGkdycWpSALf/YvNu1vpE=;
        b=WuQKVaB3lxDvbE11ewqzgbeCAiF+XdjwgakbEmyBVQbZM9trNBYH2A6HhXQVl0Nqru
         zudN25lSPgXxphRBIsn/3TwyW/p5biL2S3MUvNzH6NVKD71g50ChQjgWe9Plzh1B5vWj
         oaoY77MQJx/1kCtYZD24JH/WE67Uag5zok5Go/5Uizk1b6wTPJM3r3zeouvF48nRbORK
         99f9Ts2RWRDe3Bq/rK8u+G/YAR5QE8GwQ4PrXas+wOCvBmsy9OJU0tpdJIUe89IfU/5c
         8qm3VgJUFK+zE6reAefgVfKhKytTJhr+lRJj8R3NrQcz7ssyRttXM7rc/aAhBh3bXWcl
         vQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=AUDZk6MjTqL+H7mCm4hIxTxGkdycWpSALf/YvNu1vpE=;
        b=Lbg+vAkeH1Ode96ZM3C0cvOdy3EI33kDl8udKXwoVrE+KKLpgW7g0d2fzEBrx1sYMg
         PFpxtQXDBGzWAyljzmtiLo9eatcXIniILEaxe5I5BqnTuYBvVRY8lo44Sb7lD6O0Fr2y
         58dci/+xfJZMUESSdYkRkw+tQOldvX5Re+kTMez7FZqMQSIyYY8f6ykbObZOOhg8z2oI
         9tolv/lGuISgBL3RE2q8qLKp5rna+EpKwCS1evZ3qSfdkgmmL1fTXPNofMygJGJm1QZ9
         D5DdZ1pemFkdDGlv365QdqjtWhzHSPpVT1u+qLDhFCm6ulVQPBa7HjFwNPfsUVLnouak
         hfxg==
X-Gm-Message-State: APjAAAXa3CjSU4lnFlM8lM9Zbu9xUlgLCSdQsKdGk+LRsMC7FJDkff25
        VluwtAlO4JUyhmaqHEopqkl9DbDnUFw=
X-Google-Smtp-Source: APXvYqyblPPkmvasnPTgbmNbWfcBjhTDAef+sAAlCJUki5s6jZvrC4HQqFD6RGDhY27rOjXc0EmX6A==
X-Received: by 2002:a65:62d4:: with SMTP id m20mr5533810pgv.416.1553204679207;
        Thu, 21 Mar 2019 14:44:39 -0700 (PDT)
Received: from [192.168.1.2] ([122.162.170.241])
        by smtp.gmail.com with ESMTPSA id l28sm14133932pfi.186.2019.03.21.14.44.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:44:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Aaryan Kapur <aaryankapur1309@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 22 Mar 2019 03:14:37 +0530
Subject: Gsoc
Message-Id: <CAA7E357-816D-4BEA-8806-4CB180FF0BD1@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPad Mail (16D57)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, I would like to work with your organisation for the upcoming Google sum=
mer of code program , please guide me on how to go ahead

Aaryankapur
7507442555
Ak6392@bennett.edu.in=
