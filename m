Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538FAC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FD960FC0
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhIPWrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:47:39 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:45244 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234282AbhIPWri (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 18:47:38 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 2A0E61B267;
        Fri, 17 Sep 2021 00:46:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 1B2881B685;
        Fri, 17 Sep 2021 00:46:14 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YvcFl0nWwI6n; Fri, 17 Sep 2021 00:46:14 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id C499C1B58F;
        Fri, 17 Sep 2021 00:46:11 +0200 (CEST)
From:   wesley@schwengle.net
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: Possible git bug
Date:   Thu, 16 Sep 2021 18:46:02 -0400
Message-Id: <20210916224603.2912887-1-wesley@schwengle.net>
X-Mailer: git-send-email 2.33.0.364.gff7047fb76
In-Reply-To: <xmqqtuikrzca.fsf@gitster.g>
References: <xmqqtuikrzca.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=U7vs8tju c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=7QKq2e-ADPsA:10 a=MAxO3dD-BlnYMv0srZAA:9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I failed to include the correct format-patch, 3rd time is a charm :)

Cheers,
Wesley

