Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57FA2022D
	for <e@80x24.org>; Tue, 28 Feb 2017 07:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbdB1Hee (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 02:34:34 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33434 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdB1Hed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 02:34:33 -0500
Received: by mail-lf0-f50.google.com with SMTP id a6so1736952lfa.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 23:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DYTTafTxaKVNv18lQkYAZBZfJXR1QCqjwhMv4c30WqU=;
        b=Oj4/qm9DqmylonZWBFxv+e5FHbIJDMeOKggUuoBTHUKAaPaJSPF0MLcBYLNMNPwBL+
         ZbdPuvGTtDTR0HzxGt9mNeIk6wLzOpYS0p/Jw/Wo+pfMzRQJEG6uQ6Rhqzd5pkso/Me5
         +LIHnglTBDfftHvJJM3HdVCJxRfE7kSiEdoyzLUbFTxcxNAZkwIX2TH+JvpsUDuhj2Kh
         2j9zOAv0vRWYemFOUT+QC33tSvHSGGptJO4WRHqOBtOmzhWCjajVaq9Mq0s7c/97FTeW
         fxaGGy031odNsbeUtVngO8ViTTHagDLO98XNnlCz97sBf3bbg4AYIJqS5T29l830E76A
         sdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DYTTafTxaKVNv18lQkYAZBZfJXR1QCqjwhMv4c30WqU=;
        b=e+9VIWgOhO7slnlidlrF1tqdsikDl3t/nLSNvSZ3MuFK/8ozXDw0FGrJvwJCqvQnOa
         IsfeW25h6ey6Z/Z3aABt8pgki/PzFCQDgB1bgZIZi573QgTgSd9bVZNm4OaUKGLB+IFk
         LWIDFVrqTVA4773jMNrSvr4zYEtIslioiUnYTALesaoCrOV6LkIvyexEdT4iElDBRDho
         sTuAyYH4kBo7FJaRgkabbvZonFPSLtsbzQXljJEIkv4Ng42hNl/CWey8ZTSCRYIejVns
         8m9dmVpWR+zLF67D9Ez0oOO2onpCjzTX2ju52BicuYmxlwnALSsFJGElX7JQQeY75U0A
         9KFA==
X-Gm-Message-State: AMke39nE0sYm2m6HLBGkr7o0lm6HBF11ekFldkJWOe9AyxSAk7KMt97gGHyT6toQfRmz6HjlzLiz4iWSkj5LLA==
X-Received: by 10.25.216.28 with SMTP id p28mr277438lfg.164.1488265493102;
 Mon, 27 Feb 2017 23:04:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.204 with HTTP; Mon, 27 Feb 2017 23:04:52 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Feb 2017 08:04:52 +0100
Message-ID: <CAP8UFD1+Yn8W3YXF6Wn3=7Kiim9h6WtK7cqDu1G0uF8+CuORQg@mail.gmail.com>
Subject: Git has been accepted as a GSoC 2017 mentor organization!
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I am happy to let you know that Git has been accepted as a GSoC mentor
organization again this year.

  https://summerofcode.withgoogle.com/organizations/

I invited Dscho and Stefan as potential mentors for Git. I also
invited Junio to give him access to students proposals and the
opportunity to comment on them.

Tell me if you want an invitation to mentor too. There is no
commitment to mentor anyone for now if you accept the invitation. This
will be decided later. You will just get access to the proposals and
be able to comment on them.

As a reminder, our GSoC related pages are:

  http://git.github.io/SoC-2017-Ideas/
  http://git.github.io/SoC-2017-Microprojects/

They could still be improved which can be done through:

https://github.com/git/git.github.io/

Thanks in advance,
Christian.

(PS: Matthieu, yeah I used your email from last year as a template for
this one, thanks!)
