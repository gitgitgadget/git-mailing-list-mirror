Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D34C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6EA206D3
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 16:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tilde.team header.i=@tilde.team header.b="mdsHqfx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgAaQDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:03:31 -0500
Received: from tilde.team ([167.114.7.65]:50364 "EHLO tilde.team"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgAaQDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 11:03:30 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2020 11:03:30 EST
Received: from mail.tilde.team (localhost [127.0.0.1])
        by tilde.team (Postfix) with ESMTPSA id D1C082E20075
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:56:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.team; s=mail;
        t=1580486215; bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        h=Date:From:Subject:To:From;
        b=mdsHqfx/KCIe9/ov9kTHWBCSCFz/cNss7kHL82U+JGuuVL99V/4C3Cjg3/zlYhnvr
         M1zhYgx+MkaiGvekFuentQlMgEkV1dvjo73Ncus2TD1M5NfSstlUqbCx9Qk81yWZEw
         oh9LLsqw16NpVm6k2YpU/EaXpg9/f028KH01NKmU=
MIME-Version: 1.0
Date:   Fri, 31 Jan 2020 15:56:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Ben Harris" <ben@tilde.team>
Message-ID: <d56d8ff721f5a10ca00cc483562b311a@tilde.team>
Subject: command
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe
