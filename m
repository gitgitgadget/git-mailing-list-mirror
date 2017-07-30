Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0FC8208A0
	for <e@80x24.org>; Sun, 30 Jul 2017 14:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbdG3OGw (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 10:06:52 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:32997 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdG3OGv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 10:06:51 -0400
Received: by mail-ua0-f173.google.com with SMTP id 80so181688477uas.0
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:mime-version
         :content-transfer-encoding;
        bh=7g7fIFELLHfS2aX26h+DzOtHyaVOcu2RM4xSCf9qQqI=;
        b=sIEx/El7c/Tj0NpYw77J5uf4hbOneERLU/oqwxSj4fUxynBNvgMXjZZiHk4HSN3cNu
         UPf/i2+8OP7M4OZ0OPk4V6X20NnyLSPgdl939JpQ2Ai/zBMyQC+pbYDWOfmx5JKCavPu
         81AeFiZyDXp0lKreBGarW/DR1MDkhmgCPZWfWBRAVkLvlb6HNaLDmfAt96jAaXyaeyi6
         k0PMmnlwpMVwm7+IMeinugZnXMsli84AKW1LTFaqdGENTojNDLHAjn9jvkXHx7mgVdLE
         ZyNom1DDif9NRKTGSYV1AAIGEPq5iWHWQYqUOi20fx+qTo8CLHsr6BPKZx5icPNHGdH7
         VKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :mime-version:content-transfer-encoding;
        bh=7g7fIFELLHfS2aX26h+DzOtHyaVOcu2RM4xSCf9qQqI=;
        b=lLQCRiTR3LXtItZaxJ/uOR7NGr8KyDZsDS8JFD1SsYfDcpBYX9JaJstgB2ubCqQlMF
         eZw3LbpLMPAoqLzG3Ab/HkWOr5syqiTlbTJB+eVuxGI+/sQRVKxKjBR5adXsdcVoeARS
         XuKKIrVrqYx1GFiteq6GI4a3WJPa0xxwJz2ZuBAIbGdLO6fcpWY0pQxfM+wjg+/chTRu
         MU/Pie7J7TOsCKn1Os+nzSBB1EuMftxwJ4zFnqHTHLoP4ra43k6Y0VNRinw2tzNk+JSn
         lEXcfe37gXx4qWmDK/TQO474l18QQrfkPjIA1QB+vIZWBlZOkzgVx+cgysqzPKItfhUU
         5ijw==
X-Gm-Message-State: AIVw1111aLmT1xmzSFbZsNa1LugJ7Fz9i+Sd3G0UGECe6pAEEeXUdm1h
        nBc1XW35+J9GGGomgAytDg==
X-Received: by 10.176.1.169 with SMTP id 38mr9750379ual.32.1501423610390;
        Sun, 30 Jul 2017 07:06:50 -0700 (PDT)
Received: from [192.168.1.7] ([190.236.205.11])
        by smtp.googlemail.com with ESMTPSA id 31sm6073900uap.21.2017.07.30.07.06.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jul 2017 07:06:49 -0700 (PDT)
Message-ID: <1501423608.3232.30.camel@gmail.com>
Subject: Contact with Latinamerica
From:   Christopher =?ISO-8859-1?Q?D=EDaz?= 
        <christopher.diaz.riv@gmail.com>
Reply-To: christopher.diaz.riv@gmail.com
To:     git@vger.kernel.org
Date:   Sun, 30 Jul 2017 09:06:48 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My name is Christopher Díaz Riveros, I'm a software development student
in Lima, Peru. For some time now I have been supporting my Linux
community, Gentoo Linux, and I have discovered a wide world of
possibilities in open source.

I tell you this because it has been so much benefit in my training as a
a developer that I am determined to start a new community in my country
to be able to make technology-related career students find an open
source community in which they can learn to work and get the same
positive effect that I have had on mine. I have already been talking to
some teachers, I am about to begin my final year of studies in the
institute, and they agree to start the community with students of the
institution.

As one of the main problems when getting involved with a community here
is the barrier of english language, and few are able to have fluent
conversations in that language, as it is a bit intimidating for most to
approach an open source community. My community hopes to get in touch
with different open source projects throughout the world and seeks to
be a midpoint to interact with young developers and communities.

Having said all this I have only to offer to your community, the
availability of our community (we still do not have a definite name)
and see if anyone is interested in supporting this group of developers
here and with a bit of luck be able to turn it into a movement of all
Latin America.

Thanks and any kind of feedback is welcome :)
Christopher Diaz Riveros
