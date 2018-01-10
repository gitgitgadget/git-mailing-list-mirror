Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020BD1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 17:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeAJRk2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 12:40:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:54825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbeAJRkY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 12:40:24 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1f39PD3Psq-00eqIk; Wed, 10
 Jan 2018 18:40:19 +0100
Date:   Wed, 10 Jan 2018 18:40:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc1
In-Reply-To: <xmqq608a37ve.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801101838360.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com>
 <xmqq608a37ve.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yeX3OiBvN6yH1TaKSCxvJlJuDj2ic9yP7SCzQlL4jZDN65cSDmB
 /J9O2Px6+iXuQzCffmHPjohEVWGX4+9YEm6TH42Yq3wWczQqf9v6jLNpCGZuYElhC1M84L1
 8AELCFYo9yBmvdlLgds9RY/edSo+2tuBLhvIh+XoqKjiShS1LC1a7QHonGfrXgh5AgM/LMP
 Ft8RKaCLpISw3Y16yLnFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZkZAGGbRDe8=:lYZfZnizycDe9u/ncgoBVv
 o/pJBa6krkAyrPqFJ+bhG+i+CL8U0twMf+GdjOTB50vixCVzhWJ8qma++/fgmzC9vSIBE82A7
 i1aE+AZvp6KFdSTpmzuTb/fLqivzGLq0nb/y7jTtIFsAUci6ST2cjMR6oAoBm6gBqNNFxeAQc
 6bteEj7oEF1EvtjyNvi1UeQuU56gmuJyfO193+MSAO9V3tIrxEs62h5oIbiv3RikUWq4T4H16
 fKcZuepubaSvVcM9PmnalnmujcdwVL6/7VTG/NsUh8wrKXf9eBzZpQrC4hZtDYaYDU+GRrDFQ
 Yt8GWlVYRm6MXThvin1+nAfIxsSF2WFA4etMiWW9FHBYBJlWV19vVF9pzzofL6V6CQZC4EXmL
 mhxirJ/V970+Mh+FhFhBpLL2GBydCdmrG7ligkYI2imiyYFry7cBPCkP5rApPV6NouyqgDO3o
 G2cV2Qkg0p3cfDSFeTkGWxTIEFhnBY/UJc/n+9ocqALisGT/UDtE3K93//SZkKAZBSjuMs+2W
 hCaXXz3RFsVXWyjQ6dJ6eX1gfZKo7wlBdLz+AaMuRz9lBPrtK2f7ZeqnwRrmK5MKPcS8Y9db7
 L/LAQ7yrA3oG9VHHcmmh75yV4hq73ygvnME5A3nRj+l6T3GxhPMiUzXHHMrYHlKG0Ljdoi676
 m2/1QUv5NNhjuJ9BpfzEiNQvBXTr+sCdxdHzElCrn2w1FTye1XI039zdlUuBjcTkbReWCG2B8
 PJj5l1pIrr/acgmBFtdW/qZLEftkvehr7NJkClpcYqPvh/PPe5+ZQQwHGegX//7M0NAfaWS1P
 jVwE7gj88137pecXv8tk1uMORDmX4kg3fFldZwpoEXS1zZHklM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Jan 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> >> index f1678851de9..470107248eb 100644
> >> --- a/t/t0021/rot13-filter.pl
> >> +++ b/t/t0021/rot13-filter.pl
> >> @@ -31,7 +31,22 @@
> >>  #
> >>  
> >>  use 5.008;
> >> -use lib (split(/:/, $ENV{GITPERLLIB}));
> >> +sub gitperllib {
> >> +...
> >> +	if ($ENV{GITPERLLIB} =~ /;/) {
> >> +		return split(/;/, $ENV{GITPERLLIB});
> >> +	}
> >> +	return split(/:/, $ENV{GITPERLLIB});
> >> +}
> >
> > This cannot be the whole story for a few reasons.
> >
> >  - In t/test-lib.sh we see this:
> >
> >    GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
> >    export GITPERLLIB
> >
> >    If this part wants to split with ';', then the joining needs to
> >    be done with ';' to match, no?
> >
> >  - In addition to t0021, there are similar split with colon in 0202,
> >    9000 and 9700, yet I am getting the feeling that you observed the
> >    issue only in0021, to which I do not think of a good explanation
> >    why.
> 
> This somehow vaguely rang a bell, and I dug this thing up from the
> archive, [*1*] which ended like so:
> 
>     >> In our C code, we have "#define PATH_SEP ';'", and encourage
>     >> our code to be careful and use it.  Is there something
>     >> similar for Perl scripts, I wonder.
>     >>
>     > We probably should find a better solution to allow this to
>     > work with windows style paths...? I know that python provides
>     > os.pathsep, but I haven't seen an equivalent for perl yet.
>     >
>     > The Env[1] core modules suggests using
>     > $Config::Config{path_sep}[2]..  maybe we should be using this?
> 
>     I was testing this recently on the Perl included with Git for
>     Windows and it returns : for the path separator even though it's
>     on Windows, so I don't think that would work. The Perl in Git
>     for Windows seems to want UNIX-style inputs (something Dscho
>     seemed to allude to in his response earlier.). I'm not sure why
>     it's that way, but he probably knows.
> 
> Your initial response in this thread made it sound as if -rc1 is the
> only thing that changed, but looking at the differences between -rc0
> and -rc1, which does not touch t0021 or any other instances of
> "split(/:/, $ENV{GITPERLLIB})", I am wondering if it is possible
> that perhaps the way Perl is built for GfW has been changed recently
> and we can safely and sanely use $Config::Config{path_sep} (contrary
> to what was found in late Oct in the message quoted above) now?

No, the only thing that changed was the introduction of Git::Packet (and
t0021/*.perl uses that). And that Perl module is not yet installed.

Granted, we tested incorrect versions of those modules, but this late in
the -rc phase, I would prefer to be cautious. People might be relying on
the current bug.

OTOH I might be way too pessimistic and we should essentially replicate
that `sub gitperllib` trick in *all* of our Perl scripts.

What do you think?

Ciao,
Dscho
