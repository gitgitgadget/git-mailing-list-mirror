Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_50,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB7C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5909064EC4
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 21:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhBYVgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 16:36:42 -0500
Received: from cock.li ([37.120.193.123]:35322 "EHLO mail.cock.li"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S231895AbhBYVgl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 16:36:41 -0500
X-Greylist: delayed 4197 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2021 16:36:41 EST
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
        t=1614265241; bh=Ik0jAAaQcRJ25rm/9XvKOpVcWs1NPoGFn7+TpOp/PoQ=;
        h=Date:From:To:Subject:From;
        b=TrH576KHjk26SABGzKmheqMzWwUkGcndrBy+fyBULejvk6v83LGFlv1lEyhMxg/J8
         1KljHeWul1aJS5PKlndUJ+f+SkxuvF4UnO6cqt8CcRG7MhJ7aTK00B1wxkQJcwEOfX
         Nl99dyo7hRPQYE7Uh9Xx8g82I/bCd9KR1/FyyuIONEw/38hsuj/8ffX0titOyvCfEe
         AlBc3XR/dWwNmQe8JoSIn03yDdwZvQSJhFXKGu5IshfZeTm7aQS86dW+MkpvTlnHE3
         t0Dm/xEzdDF9NiI7P5eluorVGwIoNRy7QkIcOWIye+x+jWLzeGEuEcQzIHVO8BjTZz
         OCRLos6a9CFJQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Feb 2021 16:00:41 +0100
From:   mantheman889@cock.li
To:     git@vger.kernel.org
Subject: plsplspls help
Message-ID: <e7162c0bf37566dff89d05201f531e55@cock.li>
X-Sender: mantheman889@cock.li
User-Agent: Roundcube Webmail/1.3.15
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pls make the git push --set-upstream origin <branch-name> automatic :(((

i dont like typing it on my ubuntu terminal window when i make a new 
branch ;'(
