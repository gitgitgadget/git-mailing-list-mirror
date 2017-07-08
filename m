Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166FA202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 19:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbdGHTaa (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 15:30:30 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:55252 "EHLO
        homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753016AbdGHTaa (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Jul 2017 15:30:30 -0400
X-Greylist: delayed 99189 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Jul 2017 15:30:29 EDT
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 153E4348070;
        Sat,  8 Jul 2017 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jidanni.org; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type:
        content-transfer-encoding; s=jidanni.org; bh=9fhLK3APxpnikhNowq6
        sRMm3I4k=; b=XTjsPorgrc/rDiDkGJyhzyM1LbknHeE0qUq3T6l+Rus7LzwUeT8
        YG+KtWRNaxVRlVTMWUAFMw+b6C43UdN6Lnwd+tQEIgpNADTskET3m2GE1tLssxAU
        sRDnAmI4OPRO/W2bGxMqYd481MDFbsa0oizd7Makf0w9x3dfDNWoWkk8=
Received: from jidanni.org (220-140-14-219.dynamic-ip.hinet.net [220.140.14.219])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jidanni@jidanni.org)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id D108D34806F;
        Sat,  8 Jul 2017 12:30:28 -0700 (PDT)
From:   =?utf-8?B?56mN5Li55bC8?= Dan Jacobson <jidanni@jidanni.org>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, 867600-done@bugs.debian.org
Subject: Re: 0 bytes/s vs. =?utf-8?Q?=E2=88=9E?= bytes/s
References: <87lgo02qat.fsf@jidanni.org>
Date:   Sun, 09 Jul 2017 03:30:25 +0800
Message-ID: <87eftqiv5a.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RS> Subject: [PATCH] progress: show overall rate in last update
RS> Reported-by: =E7=A9=8D=E4=B8=B9=E5=B0=BC Dan Jacobson <jidanni@jidann=
i.org>
RS> Signed-off-by: Rene Scharfe <l.s.r@web.de>
Thanks!
