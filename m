Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92E91F424
	for <e@80x24.org>; Fri, 27 Apr 2018 12:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758235AbeD0MSl (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 08:18:41 -0400
Received: from mail.itefix.net ([136.243.133.44]:42730 "EHLO mail.itefix.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757830AbeD0MSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 08:18:38 -0400
Received: from localhost (mail.itefix.net [127.0.0.1])
        by mail.itefix.net (Postfix) with ESMTP id 8FFDF40CB0
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 14:18:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.itefix.net
Received: from mail.itefix.net ([127.0.0.1])
        by localhost (mail.itefix.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9M3sH80I24pZ for <git@vger.kernel.org>;
        Fri, 27 Apr 2018 14:18:35 +0200 (CEST)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=itefix.net; s=dkim;
        t=1524831515; bh=uQ7qzjePrCbs4/sT11eDebrOlJ9XY9TQsEGj7RcYjcc=;
        h=Date:From:Subject:To:From;
        b=i7OA7dD2GKPOvQHgELLLskWI1V41hla/CpMUcVrQedpUMw10VDisfdnvfEqf0auJz
         8R23Z5Hiby7tRh0gNdK5m5fIqB87qlyfKXrabFHfpNZyqQhmSME7SXQ0ig79d1fIBh
         ohGQz3ao8NUZtLuW9XkE9G6/35U+01TVK4Z3nTH4=
Date:   Fri, 27 Apr 2018 12:18:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   tk@itefix.net
Message-ID: <80cbf2345db736d594789e77b45f92cf@itefix.net>
Subject: [ANNOUNCE] Gitwin: Git Server for Windows with SSH/HTTP(S) 
 transport and Gitweb
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,=0A=0AThis is a ONE-TIME announcement of Gitwin - a Git Server for=
 Windows:=0A=0AGitwin is a packaging of Git, OpenSSH, Nginx and many othe=
r related tools to make it a ready-to-use=0Asolution as a secure git repo=
sitory on Windows. It supports SSH and HTTP(S) transports as well as=0AGi=
tweb with Highlighter and Gravatar support. A free edition is available.=
=0A=0APlease visit https://itefix.net/gitwin for more information=0A=0AKi=
nd regards=0ATevfik Karagulle=0AItefix.net
