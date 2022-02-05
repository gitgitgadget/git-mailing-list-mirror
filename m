Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465D8C433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 17:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380779AbiBERmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 12:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiBERmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 12:42:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FF2C061348
        for <git@vger.kernel.org>; Sat,  5 Feb 2022 09:42:06 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 124so27688392ybw.6
        for <git@vger.kernel.org>; Sat, 05 Feb 2022 09:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=EU543TGTWNWGOTMH/q9VZ223KzA5nyDo755GzX8sGJ0=;
        b=Xz4ELbuPlCfiArE76qJouIlLQNPHOTcEMMEW7h0kuIWILuIL5yp/oufNyMxtNvdPqu
         JzP6JFzJFC2HsJP2fhem2aPUOIwppeq3QTWhFeBgpnvQVrvbwXNgLVNdWs3mYfRZ2f3O
         1/LbtoSEdB2DK6SVIMU2ox3ehN9STg7bgAq77/KS07OmyrGFID4tyD5jjd+zZB7Qy3yS
         x1y7wfyBS5qu4RZfIo/fNXjP4kJ60od9xf28mHaPrPJZqrGFjpRFSHQPR/GObwUTXtXp
         fpCFKe5FFw7IXeYNcOOrDgw51w0MAJ2bUR4LECmtx1h1C3B3e9MJcrvCgn5WFSOD+lz+
         aazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EU543TGTWNWGOTMH/q9VZ223KzA5nyDo755GzX8sGJ0=;
        b=ucWMtV2xJXkTC1N5j2XO7i6pH31dh7Zt4hZhL016IJ2UoiNLOHDzS/gAfWZDT+temK
         LFYVxn1ZPyHkwTl1U6xqieDFE2TUdWmZXV4RG7jD+61qet/fN8fp4TIbxy5uq8JQtuTu
         2e8kv7pbzRBVpO/NGMVWOCSEdsPViP9uVF2R+c8PVHl4yhXOJ1fOwPkj4Vhxjb9FtjHT
         A1ndrSLWHen7pgJyjb/qLNclTAb9zEpdf1/Af3ccVu8drABVltwjp1LU7dwb6/J2mzku
         3VPuvdjvNk3pfOvB9AyEswkoiN7az2lst5acKNmSy13SUdJTQ5+GTLclVRQaRWieMov5
         5ZJw==
X-Gm-Message-State: AOAM531e3CM6/FgMI6JRIX8RS96VqpbU5Bv1yNQZKQdGek0iSaaqTBgM
        MtUy2bPODDTD2dQ3TeVke4v3tw5zRRoOHibiSZSWhlBiyCIZtw==
X-Google-Smtp-Source: ABdhPJz/1m8WZm1ofldS9LHNP2YQcGaokznqOgUrwx8gke2LFfgCMI1crVfMTOEK1/U+kFFowCVo14XpogrIAQl5m4g=
X-Received: by 2002:a5b:c6:: with SMTP id d6mr1845218ybp.273.1644082924400;
 Sat, 05 Feb 2022 09:42:04 -0800 (PST)
MIME-Version: 1.0
From:   Samarth Mayya <samarthmayya@gmail.com>
Date:   Sat, 5 Feb 2022 23:11:53 +0530
Message-ID: <CADy+vq_H-McBmPpFbdvkajoruK3fkn9=yALORjku=upT6cQjkw@mail.gmail.com>
Subject: Summer of Code
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Mentors,
I am an undergrad student who is totally new to open source, and would
like to begin my open source journey through GSoC. Could you please
give me your valuable opinion on what I should do in order to
strengthen my chances of getting selected?
Thank you,
Yours sincerely,
Samarth Mayya
(Bachelors of Technology Undergrad,
Computer Science,
NITK Surathkal)
