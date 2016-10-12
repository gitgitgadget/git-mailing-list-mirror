Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	XPRIO_SHORT_SUBJ shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A421820989
	for <e@80x24.org>; Wed, 12 Oct 2016 10:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932614AbcJLKvA (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 06:51:00 -0400
Received: from wp069.webpack.hosteurope.de ([80.237.132.76]:52332 "EHLO
        wp069.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932284AbcJLKu6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Oct 2016 06:50:58 -0400
Received: from app06.ox.hosteurope.de ([92.51.170.13]); authenticated
        by wp069.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
        id 1buH7g-0002Az-QS; Wed, 12 Oct 2016 12:50:56 +0200
Date:   Wed, 12 Oct 2016 12:50:56 +0200 (CEST)
From:   webmaster@peter-speer.de
Reply-To: webmaster@peter-speer.de
To:     git <git@vger.kernel.org>
Message-ID: <1066408917.43087.1476269456819.JavaMail.open-xchange@app06.ox.hosteurope.de>
Subject: git diff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev60
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;webmaster@peter-speer.de;1476269458;e30b8b82;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I created a new branch named hotfix from master.
I switched to the branch, changed 1 file.

Now I want to see the diff from the both using

git diff hotfix master

I do not see any output (difference).
When I do a git status I see my file with status mofified, not staged for
commit.
Also, I can see that I am working with the correct branch, hotfix

What am I doing wrong?

-fuz
