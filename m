Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CA620281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdJCAIm (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:08:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:54626 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbdJCAIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:08:41 -0400
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lugbo-1dH0L918qm-00zqr9; Tue, 03 Oct 2017 02:08:39 +0200
Date:   Tue, 03 Oct 2017 00:08:38 +0000
Message-ID: <20171003000838.Horde.GkejIyyuKI5nlVernhZ1XQ1@bedhanger.strangled.net>
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH v2] request-pull: capitalise "Git" to make it a proper
 noun
References: <20171002225636.Horde.mXj_gBTKz-CxnFKzUqiNDA1@bedhanger.strangled.net>
 <20171002230959.GU19555@aiede.mtv.corp.google.com>
In-Reply-To: <20171002230959.GU19555@aiede.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Provags-ID: V03:K0:J35OaOkge63ljB2a31LkTEPGUtu98mRC67f9Mlpt71jhPKBvgNR
 W2rP7vD0TAKxWLtnSb9Aa55ltADCceg2gB2idROcSJsEzWiKIG/f0PTX94MaE0/495uSSWv
 qR8M4/n021VgxeWozjnpfDE8yGmQi08/HhqtspkfyuAAt2sEo+fwyLJGZ1uKCgAmHLMu7dn
 xBgUNxyIBqHkzXJeFXacA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NMOIHUesDno=:zkpw8OBOmSEfAQRGIucX7w
 u4rsa9tN8XdUlIZ6rEXa/OfsjLVX4XA9peoyxGxnV1y46yMtSEykRYeb2k2DgSG1zfikUiZTY
 c/pJCb2slC94MU9SLyXP0DXeruK0end82MMekKImo9LXiFJf8BSvW6e5KTjvNs7732JjLFg91
 Zf0jRO1wXDn+DmiELyI1eMhMfyQaOhUzqFhQxo0dq3pRAvOsviplCWVVGRqLY3zDFoMS4AjMh
 Iz7pmMjVkZH2WT0qSS9pKEY9wYp878nkmKkiEkElokt5ujppjiW81eD3y4mFYeA/veeGYFQcq
 XWAli+ay3jcetns7ij11q7xkZ4WO7pQl6r5xDm6jo0TQNv4scFl0fPObfTy1DkGBr1gLITtSj
 i77tP07pHJWA13KoZKpKraogvStnDNnxkvS8FyJdrH0pwmDRXZXivZ2PEMbx+2fBK5T0KAxSj
 XxQf3M8J+DBKU6WYrhzRuPdgucW6091fKK5BRbIsx49Mg/ZWQw1rVMl75w2U3JQ1UrOWPjrZ/
 DcstUWQpOplQq4k6caKxnIP9niw/w0+tj1BlqgQlllOcq9OtuTI/N/zE556ncpwYaiM7V181D
 p7HX7HNCrYovqvYHe7luPHod+b3/qh1t3b0cr4uynSywB9GfmsAvf9ni1dAdTiRM64QTpGE00
 fcq2djDOvkoIH+puT0yUP+EheCDspauWFlgTo0WE1FxszHgb0maI4cXHK1WsEu0xK6ZgXVqco
 yyjbTPSN57/nFDwH4ETNeAiVqTk1kECNbbKedUE8BdX4MAQiJ0T38eqi6scE9/sPu3M05UC16
 GEUGDYTwuk4/fym4CqiGrRmaqFkvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Of the many ways to spell the three-letter word, the variant "Git"
should be used when referring to a repository in a description; or, in
general, when it is used as a proper noun.

We thus change the pull-request template message so that it reads

    "...in the Git repository at:"

Besides, this brings us in line with the documentation, see
Documentation/howto/using-signed-tag-in-pull-request.txt

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
---
v2: rename patch, correct Signed-off-by line, add Acked-by line
  git-request-pull.sh     | 2 +-
  t/t5150-request-pull.sh | 4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index eebd33276da9..13c172bd94fc 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -128,7 +128,7 @@ git show -s --format='The following changes since  
commit %H:

    %s (%ci)

-are available in the git repository at:
+are available in the Git repository at:
  ' $merge_base &&
  echo "  $url $pretty_remote" &&
  git show -s --format='
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 82c33b88e710..08c210f03586 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -68,7 +68,7 @@ test_expect_success 'setup: two scripts for reading  
pull requests' '
  	cat <<-\EOT >read-request.sed &&
  	#!/bin/sed -nf
  	# Note that a request could ask for "tag $tagname"
-	/ in the git repository at:$/!d
+	/ in the Git repository at:$/!d
  	n
  	/^$/ n
  	s/ tag \([^ ]*\)$/ tag--\1/
@@ -192,7 +192,7 @@ test_expect_success 'pull request format' '

  	  SUBJECT (DATE)

-	are available in the git repository at:
+	are available in the Git repository at:

  	  URL BRANCH

-- 
2.13.6

