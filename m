Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFFD1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 14:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeH0SMJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 14:12:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:51755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeH0SMI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 14:12:08 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1BMy-1ff5ur33Bg-00t9NT; Mon, 27
 Aug 2018 16:25:13 +0200
Date:   Mon, 27 Aug 2018 16:25:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     git@vger.kernel.org
Subject: Thank you for public-inbox!
Message-ID: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2/O+cUd/IDcRtUU6JbgMzdid9yZxANREyvEytL7l/Mb2LeUeelg
 xbESAOQWHl7ze4Ga4XoGEIwtuNMreOQ6PYRNhHFuY8w67WjbCmLTzkne07mD1wR0XRhJ8o4
 X7EZTAif1lcn8WH+YnrkHy8hvIz9rRi1xtW11SC2z43JW7WVA1URB04nTRtCcnRHmqVhy0y
 AWxnhOsegNV4B0lqB2GbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a/bCne9vchU=:xmYMP7YSFjYdpxr682T6bi
 gp47g1nhj8daJjZ0MvCtQXZisHlhIiSDFrZ0JY3TWqQ8g4mw1aBs9wqGdHrTJ3cUyrJ6JKGVQ
 E2cmB6eMSwxCQMx5cWk38cPLW4ZiR731UlavFkQ1FRF3qKFJqOkZrGPBl8vKv2KK153nPtbfP
 3bB5fPHf//34hDkA8lrHLLfdsqEYNF3bK9xXaLgolI11DYm0kChNbX6ejxlRov7ZjeZ5UNkMC
 LnWFhUKpVs63i9IIMFvGL0i19WeYN3OdCv6XbAqSb8afwibI43q44H2ymP3KBShvVs4IIKqvs
 qZBfsdSLJZlsgjuZh2QIAMo5cc+U1kslWj/68My5ShJmLf/6W4wIiIsXSSgFihe7/XdKIhwiH
 M8SrV8vzjBqpfOlyEzDT2Uj1+fXeorG1zKuC3DaUeVkf9qmn/EOUxQGkh5b4yiuRbMOnOotHc
 k5tDBSTO7G0Y0FiHu8Im+2J1NCMfYFLJA64ci/ShHZY7QSGxjbG8JQMXtE6D66K6ilKdXdA2G
 kegNG7FAYEePsVdH+RSe4T36G/twCPdVvOEqesBfrZp2efcpvlBTld8RVyUvovFFXQgYy6UzP
 5lntxxfBnZeYE1aogUHMKKBWHRK9zzOn/NrFHBkPjwvrjD0mfSwGQvAooNnUYRVPJbdOvLNJx
 q4DpUovu7lm9VpnQbN3PISqrzeeN82yNyr4whDKoqFfmQC5qCvsxuosQd2N8kLzS2nyf301Ri
 LY5x4W34Vc6fiG7NpUGTKkPpl3xOeaHw49wvgZC9gBET97WhLL6Vq8KX+h7bvXOjfty+ETIkp
 FOw1YWW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

I would like to take five minutes to thank you for public-inbox. It is
invaluable for me in the meantime. And I think I will never be able to
thank you enough for it.

Just a couple of things where it is super useful to me:

- Recently, my mail provider started dropping mails left and right. They
  might even be addressed to me, and they never arrive in my inbox (and
  not even in the spam folder: they just never arrive). I spent some ten
  hours this past weekend to script identifying the mails in public-inbox
  that I never received, and to weed through them.

  It seems I missed some 4,000 mails. Thanks to you, I now saw those mails
  (although I had to delete most of them after reading only their subject,
  in the interest of time).

- Many a times when my automated builds identified a problem with the test
  suite, it was a lot quicker to use public inbox to identify the mail to
  respond to than to use my mail program.

- Sometimes, I find myself in want of replying to a past patch, but back
  in the day when it was sent I thought it would not be interesting to me,
  so I deleted it. With public-inbox, I can easily get it in raw format,
  i.e. put it back into my inbox so I can reply.

- I cannot tell you how many times I send a link to public-inbox to my
  colleagues rather than forwarding a mail, because the former will give
  them more context (and also semi-live updates in case somebody replied
  to said mail after I sent the link).

A couple of things in the future that public-inbox will make possible for
me:

- You probably are aware of my GitGitGadget endeavor, a project similar in
  aim to SubmitGit, but a lot more integrated with the GitHub experience
  (and not requiring you to hand over your mail sending credentials to
  AWS).

  One particular feature I found myself really wanting in SubmitGit (but
  not possible due to its one-way design): I want my Pull Requests to be
  closed once the patches are integrated into git.git's `master` branch.

  While this feature is not available in GitGitGadget yet, I am well
  underway there. I already have a notes ref (`commit-to-mail`, available
  via https://github.git/gitgitgadget/git) that annotates commits in
  git.git with the Message-ID of the corresponding mail. By "I have", I
  mean: there is an automated task that uses public-inbox to keep that ref
  up to date.

  I also have an accompanying `mail-to-commit` notes ref that maps
  Message-IDs back to the corresponding commit in git.git. That notes ref
  "annotates" the (non-existing) blob you get when piping the Message-ID
  with a trailing newline to `git hash-object`.

  Again, this is information that would be absolutely unobtainable without
  public-inbox.

- Related, I want to annotate the GitHub Pull Requests handled by
  GitGitGadvget with the corresponding name of the branch in
  https://github.com/gitster/git.

  This requires that `mail-to-commit` I mentioned in the previous bullet
  point, and therefore would not be possible without public-inbox.

- A feature I plan on introducing into GitGitGadget is to attach comments
  to the GitHub Pull Request when anybody replies to the patch thread sent
  out by GitGitGadget.

  Also this feature would be impossible without public-inbox.

- Another really useful feature I plan on introducing is to attach
  comments to those PRs whenever a What's Cooking is talking about the
  corresponding branch.

  Once again, would be impossible without public-inbox.

So thank you, thank you, thank you, for public-inbox!

Ciao,
Dscho

P.S.: FWIW I added a mirror of public-inbox to
https://git-for-windows.visualstudio.com/git.public-inbox, so that my
automated tasks, as well as my playing around, does not stress your server
too much.

