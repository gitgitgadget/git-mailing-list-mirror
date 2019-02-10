Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3451F453
	for <e@80x24.org>; Sun, 10 Feb 2019 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBJVtT (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 16:49:19 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:47570 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfBJVtT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 16:49:19 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2019 16:49:18 EST
Received: from DESKTOP-E4U7JCE ([158.148.75.163])
        by smtp-31.iol.local with ESMTPA
        id swqZgJxhDCH4tswqZgUb93; Sun, 10 Feb 2019 22:41:07 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1549834867; bh=NDCIF/KWi0C+FDGEUF75xE2/7CkC2KdBGD/8V18d61s=;
        h=Subject:From:To:Date;
        b=pg9L/X9Ej13/vBzBG3rXCn8j4GbP0BorwBQICLerz7h3na4hlpLp3aLJNiEQ6IBuJ
         j/PgmOHi4rZnLIQWl9xt1F675c6WYaiupPEJ1RHG+J/UXRdE8xRxiUeeYxRKHEZiPA
         tAmEm1PkjuPjepqoSUL1LiGdjU5+hAC5pwCIyXBFq4dpJHpsyVFusa90yp4EXtja/Q
         mtO1yaUe4Aor21X3r10UjrKfhKq7vZMr7/sgAAoSXrbrShWtevf83nibIX6BLsoEbp
         I4cE2yBXAeKb4tbqL69qPlsOSeEzqcCq8vK577z/m70VUBKDBH6KFGmxTUpLqYenI+
         blFafxO6a7dOg==
X-CNFS-Analysis: v=2.3 cv=R4HS5uZX c=1 sm=1 tr=0
 a=GGocWB3/63TfxpwkRNvZew==:117 a=GGocWB3/63TfxpwkRNvZew==:17
 a=IkcTkHD0fZMA:10 a=q557q-TN85EAOqIkXFIA:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
Message-ID: <1549834867.5977.4.camel@libero.it>
Subject: Am a newby and I cannot compile git!!!!
From:   Fabio Aiuto <polinice83@libero.it>
To:     git@vger.kernel.org
Date:   Sun, 10 Feb 2019 22:41:07 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMR+sszkyEwhcxnbE/vc03eWdqqE8ROB5TTi3cRUCeivrgL6Ne4THC+0ojM7+cF+kCiYF2RhYB16MGe51WtGxUtXesxA/hpLc6E44b1HNoHQ4PQmUAGq
 voVpoPRlUCuMKuNZD7Snrhs3laFiUn6JJlmHCSCqG3CRpuBYRIo/p7WTagDFA2wBBntahEqK7Fsy0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hallo to the whole git community,
I'm Fabio and I'm approaching the open source world. I'd like to join
somehow the git experience so I cloned the whole  git repository of git
itself on my machine. Could yu give me some useful hints to start
following you in developing/maintaining this technology? A nice hello
to you :-)
Fabio.
