Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8252B2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 12:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbdI0M4F (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 08:56:05 -0400
Received: from mail.hostpark.net ([212.243.197.30]:46618 "EHLO
        mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbdI0M4E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 08:56:04 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Sep 2017 08:56:04 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.hostpark.net (Postfix) with ESMTP id 501B21675B
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:49:34 +0200 (CEST)
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
        by localhost (mail0.hostpark.net [127.0.0.1]) (amavisd-new, port 10124)
        with ESMTP id RLnev__HN6fW for <git@vger.kernel.org>;
        Wed, 27 Sep 2017 14:49:33 +0200 (CEST)
Received: from desktop (unknown [31.10.135.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hostpark.net (Postfix) with ESMTPSA id DA12116575
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:49:33 +0200 (CEST)
User-agent: mu4e 0.9.19; emacs 25.3.1
From:   Jonas Bernoulli <jonas@bernoul.li>
To:     git@vger.kernel.org
Subject: About Magit (git client) and its fundraiser
Date:   Wed, 27 Sep 2017 14:49:33 +0200
Message-ID: <878th02tnm.fsf@bernoul.li>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Magit is a Git client implemented as an Emacs extension.  It has been
around since 2008 and I have been maintaining it since 2013.

Magit was recently featured in Git Rev News #31 and one of its curators
encouraged me to write to this list as well.  I haven't done that before
because I was unsure how that would be received, but he thinks that you
would not object or consider this to be spam.

The fundraising campaign on Kickstarter [1] ends this weekend and while
it has already surpassed the funding goal I am under the impression that
I did not succeed in attracting many new potential users, which actually
was a goal.  The support from existing users however was phenomenal.

I have written several articles [2] about Magit that are primarily
intended for non-Emacs users.  Please have a look, especially at [3],
which starts out by summarizing basic similarities and differences
between Magit and Git/GUIs.

I have not written to this list about Magit before (in general, not just
regarding the campaign), because it still has some major issues that I
would have liked to address first.  I also plan to make Magit more
accessible to people who do not live inside Emacs, so the best time to
try it out if you are not an Emacs user has not come yet.  Now that the
campaign has succeeded, I will finally be able to tackle long standing
issues and to make it more attractive to non-Emacs users.

The ultimate honor would be if Linus or some core Git developers started
using it.  While that is probably quite unrealistic, I do think that
Magit has a lot of potential beyond its current user-base.

If you would like to see how this plays out,
then please consider backing my campaign.

  Cheers,
  Jonas

[1] https://www.kickstarter.com/projects/1681258897/its-magit-the-magical-git-client?ref=dtueui
[2] https://emacsair.me/2017/09/01/campaign-articles
[3] https://emacsair.me/2017/09/01/the-magical-git-interface
