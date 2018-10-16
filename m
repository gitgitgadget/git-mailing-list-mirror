Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0161F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJPUnn (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:43:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:34579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPUnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:43:43 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAAr-1fyq4N1jdp-00MHKA; Tue, 16
 Oct 2018 14:53:18 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAAr-1fyq4N1jdp-00MHKA; Tue, 16
 Oct 2018 14:53:18 +0200
Date:   Tue, 16 Oct 2018 14:53:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/13] ci/lib.sh: add support for Azure Pipelines
In-Reply-To: <20181016094344.GJ19800@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1810161452040.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <486d1d25183fc7b0de599a0791ed41a87cc176cb.1539598316.git.gitgitgadget@gmail.com> <20181016094344.GJ19800@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1579034729-1539694402=:4546"
X-Provags-ID: V03:K1:EMUAP+UocOiBNBqgbbfotV02ct8zj3xyfh2e6kKLlqltHZZa/1Q
 FAQQWv+s9vOiiLYVBoZTXMbZO+d9TEZUCIml/KnlGb2EaiTXCqNv32YR8KlBHNl+IlHGJTu
 rt/zUjiIgs2RzPv8vI+WHgmdaNgxboG4zIsTYOJzzT6Rwj6EhAKlAOSRiDFHV6m4NKOrZw4
 5dO++jxyXO7j4hbEML+4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RETEm5DweV8=:KHS6P5luxRRDB2tLnseCiz
 CkBzLkQpGKv0d8AqTeIIAgiChZ/4T0hYNkWtTJESt1VDMCXbDfsfXtl2+s9XsSOsybosFEo2j
 D1XFxSBDfeHTzcjN5r/fY7rQhHPpxPD3szUJzX+Rr5MeQTXCDVCLUwct82rfnS91qNN2bMGK7
 sT0xqHaDBqLxelCEAKK4GmwiQJh66hdUo6JyrQlx8v6kPny7y5ReoM/xkn79Kk4JEp9UuqVer
 Hs81V5yTHiJwuZHakg686gZVdnSEuov9xeL8geoEpQsvS3wTqeh6Xi9HIocHMLiX/uT68G4Pi
 HcjlNxwZkaVSjlzC/oreYfxmyHb2zxYUktIVmLYbi2hJSy05bBcChFyuzLI5GU4EJunHtR1iY
 LzR/qH/6tOH6gDZES3ZC5wEDn3xondJK/gsStMR2gyCTzOGZDER7wAv2bvzFdjP4MkFwTIV0L
 lFKlz2pihpGF043RSf/6BTXtvg0SkG2bewkxCrKwHbYurTtLs8OQr0igd+t0qxanECJEyRGSm
 PfDIuAQ0F81D9z+CXWA/O/ESUkfBS+fKOZFHkmpPK34EY5+2qxD6XU+PAtUs4x7k36FUapXJL
 MyMHBPGSzjDkoKx+Q7V0FmSSCjIesD/zVJaPvxcHpCWk5x3EOnl3yzRjR1MGoiyVJgUGBmDRS
 yDPb0FyMbtdgzkOIDDUdVUtLGz4kjO1iPtp4/JHcyoqCzuyD0rWjvWYL7ZXmqRy8XYR29bpLM
 uNcNpeD9wjipHJ29/Mv17rl4mDNsAvp7Y34a3mRDzokElfNhf1f+if+/9OlmgrCFYIt9rLZAV
 NQE1yeRRCmJpY3WhQ6I4SYGnycpmccKh2l13Xe9KZtuJqkMpyw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1579034729-1539694402=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Tue, 16 Oct 2018, SZEDER Gábor wrote:

> On Mon, Oct 15, 2018 at 03:12:05AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > This patch introduces a conditional arm that defines some environment
> > variables and a function that displays the URL given the job id (to
> > identify previous runs for known-good trees).
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/lib.sh | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 8532555b4e..584abcd529 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -19,6 +19,29 @@ then
> >  	BREW_INSTALL_PACKAGES="git-lfs gettext"
> 
> So we install these two additional packages in the macOS build jobs on
> Travis CI ...
> 
> >  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> >  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> > +elif test -n "$SYSTEM_TASKDEFINITIONSURI"
> > +then
> > +	# We are running in Azure Pipelines
> > +	CI_BRANCH="$BUILD_SOURCEBRANCH"
> > +	CI_COMMIT="$BUILD_SOURCEVERSION"
> > +	CI_JOB_ID="$BUILD_BUILDID"
> > +	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
> > +	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
> > +	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
> > +	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
> > +	CC="${CC:-gcc}"
> > +
> > +	# use a subdirectory of the cache dir (because the file share is shared
> > +	# among *all* phases)
> > +	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
> > +
> > +	url_for_job_id () {
> > +		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
> > +	}
> > +
> > +	BREW_INSTALL_PACKAGES=
> 
> ... but not on Azure Pipelines.  Is this mere oversight or
> intentional?  If it's intentional, then I think the commit message
> should mention why.

Both packages are already available on Azure Pipelines' VMs. I will
mention this in the commit message.

Thanks,
Dscho

> 
> > +	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> > +	export GIT_TEST_OPTS="--quiet --write-junit-xml"
> >  fi
> >  
> >  skip_branch_tip_with_tag () {
> > -- 
> > gitgitgadget
> > 
> 
--8323328-1579034729-1539694402=:4546--
