Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606FA20D09
	for <e@80x24.org>; Sat,  3 Jun 2017 08:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdFCINH (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 04:13:07 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36621 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdFCING (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 04:13:06 -0400
Received: by mail-it0-f45.google.com with SMTP id m47so25788652iti.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FB7h5YNMz6jOQ7Ab3XZVv97tmpTvLgj/+ac3hN9lNuw=;
        b=OSwVGqzHA/uRwnEcqFLp1Ac3V229e5K+j/8FYpmpiyY8w+0JJ2W7r8GAgL10kSt2Ks
         oSBe26HxdlHKN1cQ+hzXEUa0hdDr1wGvhpJnbWeX0+OccNn/3mjBOO5AtIw1+NkwLzSV
         wEdj1t/X5X5w5wup/0K//FheuG+3zYt18294n68lhcPrNGf5MwkhW5sGJxY6nSJ2ZAck
         aN42vAlJufFz2chCudT5qqSVgNgGrKe/0sWqXDj/VF2UJFqTWh+NcD3+BoQ5a+/kkhty
         sUt07hGCjIAqLqNCqgs3sGLp9CldT/TcsECAjZEmeVzuGkuRSxvlKifauGoS/c0PBjFI
         pNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FB7h5YNMz6jOQ7Ab3XZVv97tmpTvLgj/+ac3hN9lNuw=;
        b=R3ui7hv9kAIJvPLnC6PnIqOeUUVom1PmNYPMTT3tgj9UpGLXiSXDPq4DiuEE0wT0iD
         a3yJUA7w/gMLNQTpkbzm017I1Qvm+I4Y5yy9vZ3aqIcjWH/qUblpWsNwFNWhrebUjzyD
         Izx6I9VTjmy+QLOhpTAMckNbR7u8b62EapSFOqXlvbhQ0pnHZmK7zIvlT4QQ1Tt7tyy+
         CWOcsfLexK8MriAqUBgfNUK70JGGnsrrP6yhrz6pEEXvf9+i6lMRqVy/E1JFeEZ1I8Jh
         TosuMTMqY2VOEImFVXETjboju7oCkeA9faJ5xUwE3wHy0b9OivBR1qWf0wEeMM714Hbf
         O8kA==
X-Gm-Message-State: AODbwcAXrcKMQJ4TChjJxUH1LGHF27WUbGZDZQs6HQ7aVznUYTABWg/W
        gMl7YCFKczT5PJTaP3qIYaC8CwETWWbw
X-Received: by 10.36.18.135 with SMTP id 129mr2956458itp.111.1496477585888;
 Sat, 03 Jun 2017 01:13:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.141.66 with HTTP; Sat, 3 Jun 2017 01:13:05 -0700 (PDT)
From:   christienne shultz <cpshultz86@gmail.com>
Date:   Sat, 3 Jun 2017 01:13:05 -0700
Message-ID: <CAPMR3RcMK_Dt=4g6JJjQ9DVhCn7PLY2xAPXM1OgZGaqyVSeP=A@mail.gmail.com>
Subject: Git Error Message
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I have installed the Git software and upon trying to update a
repository by the "open recent repository" link and am unable to
access the menu-or anything-from there.  Instead a window pops up with
the following error message:

"\usage C:\Program Files\Git\mingw64/libexec/git-core\git-GUI[
{blame|browser|citool}]

Can you please tell me what this error message means and how to fix
the issue?  Thank you!
