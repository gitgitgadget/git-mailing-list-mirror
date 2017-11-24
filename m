Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7812036D
	for <e@80x24.org>; Fri, 24 Nov 2017 23:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbdKXXzA (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 18:55:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:54133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753868AbdKXXy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 18:54:59 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MhRUQ-1eWBax3aaY-00MfDw; Sat, 25 Nov 2017 00:54:21 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v4 4/6] Documentation: revisions: fix typo: "three dot" ---> "three-dot" (in line with "two-dot").
Date:   Sat, 25 Nov 2017 00:53:28 +0100
Message-Id: <20171124235330.15157-4-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
In-Reply-To: <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:yDKRFU8bSIErSRzAmXzFbQNw9fNOpnbUckNvz9YSiojNyfnh+52
 BCQBCKsZahWOwnrqAVwaJxu/8jCa3WprUbT3dAHelfMtRpS5lOrbiCnF0wC9iuBOu39e1dV
 csnifIDbo6IYbmwYIuYWLIt0MNBjeRgc2yIHv7/Z0dAc4qrbG/w/ZBOmJacQI9JmVWvZr82
 vcZ5FPRUSQ9P0QdtdxJCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k84r22Urw0I=:4n2g1l96m1hp4NaITsRInE
 RLp1r63Ay+4rs2Yl3YtPsObsJ0jIIZfwxHhYDr+CfEfSrtK0ujMIZAYraQPho12oBn2CkQ4Bw
 d2IboRpbngiHrqYGsZhT+JetH3AwelOqFwPO6boN7MFQjBfJIdS6YVVIDz3K8lQIsot7+CDyY
 uj/qkWN2fhjW+fbPb2o130DdTdnfqxjTL5WC6RTAciu70ef9yy4PLJ/s0qjBZMpWZQjTd8B05
 aiE/xk8lSk+5QkMQyee3fJmQujPELYg1w+0uCzSKxFYbiNxDHsFVDhkMgl9z6nYmRpRPL9/j5
 JQX/SpXq7ORRQejSNJF+pc9xvqffEC2htJEk/ddVckMIpkoUfwtYWylfPtAcJl0iU6BNuGnHb
 55IvdWIBwwdyhBZpq9oJ7TxRkmWb1Clj8SUZMXqfJpjgEHXBJnD3ZxRvM7sFC120WIkPhFEY7
 X9J9VjWC0Y6hWpeVB5NKmqGVhc1UJu4z4Lh64GCoSFpB2gmmQc4XGDoJgbVpTkq6+8yd4wlcV
 43EpJwuTR9dNZDptS9csxqpH7LyjpFY6gj2+NOKxuP3qHHOGezHD1A70Vb5NAQ0ADKI+Wrabl
 1EZMx1nYv5l28dxjQAV4Fmghv6qT6LesYiBqAgFc6DPCv6XnlJpL/F+LqTT1yJiTO0x4XGtxg
 Z3fSnC20BUprscCAp0ta7SnNpf1H2/aW4AKLLfY1kqay6b0BBioQGW3KH81jH36QOFySzGwl6
 QtOEWl1j1Qt06dI1kikcrUeY8CBsB+hpbOwjv/db1boP2TkmqJWSIEU3ZXJmlRm6UFSq2U740
 no218uW9sk+Td7t9jvZ2Pws0u6rcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 61277469c874..dfcc49c72c0f 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -271,7 +271,7 @@ The '..' (two-dot) Range Notation::
  for commits that are reachable from r2 excluding those that are reachable
  from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
-The '...' (three dot) Symmetric Difference Notation::
+The '...' (three-dot) Symmetric Difference Notation::
  A similar notation 'r1\...r2' is called symmetric difference
  of 'r1' and 'r2' and is defined as
  'r1 r2 --not $(git merge-base --all r1 r2)'.
-- 
2.13.6

