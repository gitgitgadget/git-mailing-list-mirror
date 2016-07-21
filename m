Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B50203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 15:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbcGUPzG (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 11:55:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:63519 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147AbcGUPzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 11:55:04 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LmbVT-1arkuF3smZ-00aEhM; Thu, 21 Jul 2016 17:54:53
 +0200
Date:	Thu, 21 Jul 2016 17:54:10 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:	Jeff Hostetler <git@jeffhostetler.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 6/6] Unit tests for V2 porcelain status
In-Reply-To: <CANQwDwfWW4Fn7KBHrNv2nfvGHMrPQ4jGpz6wGAEGg3edn-ztfg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607211749590.14111@virtualbox>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com> <1468966258-11191-7-git-send-email-jeffhost@microsoft.com> <578F9923.3000403@gmail.com> <578F9D2A.2030204@jeffhostetler.com>
 <CANQwDwfWW4Fn7KBHrNv2nfvGHMrPQ4jGpz6wGAEGg3edn-ztfg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1409685566-1469116451=:14111"
X-Provags-ID: V03:K0:O897tVR7BoWM7ZOqDt60blSF4Yn8CbFp/79q0Cc22zqgAfYr7nE
 TR1locDY3W4QktPoddPiSCateLEXcKu9nott2urqoXSDylZS3QIctx9hW/+W1IQWd1Lc69e
 4zoEtsO+TFmgkIrDh0b5yg37kyrLmrlZGPiUv6IStQXLO3IUutakqZmRlS05jwLeMDAYK1k
 sBUZw2GXAIbjH93csdARg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qslY2GGisgs=:+St/vIHnYwfgmd9VwzxMXB
 1hUBGkVKgrkjM2mZvXWDy5CVYeNFKowkCf39ORDIC2ZDiRkYulEvW7ok4YNkXZCJrZR8ruEzW
 Ald1gBkBix3PzGvwZiY8sa98dBvvalyklkz1bcJG91Xl7qrP/S62affjNOi56Mf0g+Y4vQKqZ
 e4mbVVgfuLY5hUdoIXwVImKMnVYfJfQeWgkf97ykiY8fCTvtIeImfCk10kagNvvNklFMAPVcb
 4MVjf3TvDBjp3GHk+SO/d1jIHWkOO1BJV7MAUiPHBLjbjtP28KZ6cxshRukiE1CNeh1TNB8wq
 11mIugaZ14XxYgd0YjmvfCfleSfLoPp+diLPqOADAENI05DCPUbQEIAwsMX1EMUXkiVvHoaNY
 jwg5PWqxr+IMcjqNwusGC+D2W8gGpgyu01JaoHAKewJ+cL5LFxC18+eKogqxOhfPeOsyJ2yi5
 wWE2uJEwuB+iVhkuydxE6BRF+BYmH1PTK0wWSIZRz+xdpnJ3bcUaOCAEdgoPW/dAC1pv5I/ry
 Y70vYpJAnesXNxGBizeUfzSCLckqbKfIQHRy6v1oNqbqoy4e0VZtxdwPrnJhKSuD1hSYpG/U9
 iSpSqcEFoLGJupJdf8dwWGrF+0Vy4GwUUNYa/eH1CwrOMFG6Eip+Rg7UfNXFKwnexUUFmzFef
 SoRqIa2AFH9yxWU4IPlBVca43Av20KRbruIdhxykwb0GYK/E7vx407qcbziL6r1M/ZN7Ac7H7
 SpnE3L+xO7a8XxRk2w5x98TADttZqBCceJu8kyyGH43k05rYOIETg9k3+Vuit7JnV4OXd0IOM
 566BtoG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1409685566-1469116451=:14111
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 20 Jul 2016, Jakub Nar=C4=99bski wrote:

> On 20 July 2016 at 17:47, Jeff Hostetler <git@jeffhostetler.com> wrote:
> > On 07/20/2016 11:30 AM, Jakub Nar=C4=99bski wrote:
> >> W dniu 2016-07-20 o 00:10, Jeff Hostetler pisze:
> >>>
> >>> +test_expect_success pre_initial_commit_0 '
> >>> +       printf "## branch: (initial) master\n" >expected &&
> >>> +       printf "?? actual\n" >>expected &&
> >>> +       printf "?? dir1/\n" >>expected &&
> >>> +       printf "?? expected\n" >>expected &&
> >>> +       printf "?? file_x\n" >>expected &&
> >>> +       printf "?? file_y\n" >>expected &&
> >>> +       printf "?? file_z\n" >>expected &&
> >>
> >> Why not use heredoc syntax (cat <<\EOF), or prepare a file
> >> with expected output in the testsuite?
> >
> > The tests involving renames needed to embed a tab character
> > in the output and hiding a tab character in a heredoc seemed
> > error prone.  So to be consistent I made them all printf-style.
>=20
> Ah, so that's the case for series of printf. I think in some other
> cases the Git testsuite simply uses HT variable for the TAB
> character.

Yeah, it would be more pleasant to read

=09echo >expected <<-EOF
=09## branch: (initial) master
=09?? actual
=09?? dir1/
=09?? expected
=09?? file_x
=09?? file_y
=09?? file_z
=09EOF

And it is also easy to use $HT in there (unless you want to use <<-\EOF).

Actually, even if you want to use \EOF, you can easily use `sed` to
expand, say, "Q" to tabs, such as was done here:

=09https://github.com/git/git/blob/v2.9.2/t/t4213-log-tabexpand.sh#L88-L92

Ciao,
Dscho
--8323329-1409685566-1469116451=:14111--
