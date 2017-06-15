Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA9A20401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbdFOTJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:09:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:53793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbdFOTJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:09:09 -0400
Received: from localhost.localdomain ([37.201.192.198]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MXZ4Q-1dHgNY1Urm-00WTb8; Thu, 15 Jun 2017 21:09:06 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.13.1(2)
Date:   Thu, 15 Jun 2017 21:08:57 +0200
Message-Id: <20170615190857.4436-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.13.1.windows.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:POw5uvTV/2hysHQ3WIXmzZ5/csUOfLKiivz5dEPqtEVzzPkaU/N
 uCQblyrjeh4PjV9cLQN3RxNT8sD/fMdubEzFzYbSawvLvRRGV9D9j+L58wqk3yHL+LeQO8r
 uwx3cR3kKeTwDIjgPl1kEL6DpobtasA+PrmxNwAtM6eQFBAD4443mX2A2WMwA0DvdYTIjLq
 LsDkKMh1e1FlFiBG+ZGeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9u+b1wJo06Q=:CQMogPecyYg2BruJ56rzDb
 FqxwKl3aYoiCP0spvBRcYdJGIBuTHbqm3FIsUXKQplEqxY+S0d6IdR6ZZ9sr9Bdda3RNQJcOq
 /ds4aMJdkYz877rRQeZ+eQOMD6Suw6qggDt5KeczTWEsvlxK7FZqP1NHuuSskbl+ZLjevYblc
 qanUVndcU9ckHNGR1usGZ7MgSIbruBGG7BfR+I/a7gs0OAo386GROjm1kKtg+46ndNg/B6UQD
 mNQXUoseBF5si3peHnqa7hqowKOUJsQkBRG56Fqjlx6q1VErNddmR+OufpSoDunWYQNDHK+PD
 2S+5PLn0Yt+QvkHHLAZZXWtJ9J0YmEp/UjfNonPE1dJTKGNOj7+XYnQRyrABzRBt7Bhs3WnpB
 3FuF9b4qtpXS28qr8aKDe5Ast/QUtS/W1nxnXc9p3aiNFEMhr6xwCp3TnXoZNroqHKM9PC8LB
 X7NaPJx5M9tC6qy7kPbDKNUFnrf9AislGRAohi7iVVzszWwqJL/vDcDS6DZnW87QvstlPwQ4y
 G4/+fGDsvGwSUspG/uk0gkt75P2CVVun/mOZpH2R5AuQdYPf8mtFPSplnQ0KYw6Sx2M4Glm69
 zRzyT61TZuXQ6oxjVU+mfzf6rEdWrv0sXm7MwqNUmt5MUf9DWSNgC3fS0PfCFodoG1OcRJ8co
 vynqh/s0bPCCYFWI1oJshus34B5+0j0LmsV7/yjQX1qcgj5h+nj9l86v44Q0O6LQMprj2QiZK
 LjNxhWbF6Q8JIJjfngds5gm5LJ21qnXOMdXNRvqQtiS6ED6fs7pZsQ+IwVu9Rmd1yBeEMDuer
 0XRf74p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.13.1(2) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.13.1 (June 13th 2017)

Bug Fixes

  * git commit and git status no longer randomly throw segmentation
    faults.

Filename | SHA-256
-------- | -------
Git-2.13.1.2-64-bit.exe | cd11e57bd25c4d8fde0a7568d19bf3fc6418dd23080901414309b144e2bf0b32
Git-2.13.1.2-32-bit.exe | 5eb854b666a77a2efc0119fc144cbba1e01a716c542f4259af1dbd4323d68fe9
PortableGit-2.13.1.2-64-bit.7z.exe | 2c98f6cab688d585d68896c8954e4849c70b33a34f8b5b6009d2ba56ddd95c43
PortableGit-2.13.1.2-32-bit.7z.exe | 7eeccb6aa3aa294a05538a913f465b9ddeb36160126caf709b378bb78630216b
MinGit-2.13.1.2-64-bit.zip | 9d3d572f275ebf69ea14bb4abfda64af78c738d2db8a54ee1f9f9db7cdfadf74
MinGit-2.13.1.2-32-bit.zip | 4b643c986a8c2455cddd2338a3c892acf111d3833384e866410785f9ea073a1a
Git-2.13.1.2-64-bit.tar.bz2 | 6fc4fa4903ff974f3960c4422269beeb3f02176029b69db0d6090986b21a9206
Git-2.13.1.2-32-bit.tar.bz2 | 9476b762c4eb007d82627e34b7b0fde6ddfae8c78f3b1d29518c68dd65f4a4e2

Ciao,
Johannes
