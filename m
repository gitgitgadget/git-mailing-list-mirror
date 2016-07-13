Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99222018F
	for <e@80x24.org>; Wed, 13 Jul 2016 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbcGMSxV (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 14:53:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:58316 "EHLO mout.gmx.net"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbcGMSxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 14:53:19 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LlqNY-1ao4Rt0NTU-00ZSID; Wed, 13 Jul 2016 20:52:17
 +0200
Date:	Wed, 13 Jul 2016 20:52:14 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607132048370.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox> <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com> <20160713020132.GA13918@sigill.intra.peff.net> <xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zlCs6btezg/IFf1P96s+5xrFaGgVXISiVQB7jEuRuq68BXBi/Zl
 fHT0R/Cxf6rKKGl4FwZNOWKEoYX+i4bZY+CXHYA+hvzlXgIFshibKQAgmKa2YTlF8/l+FzK
 5a5AkSEIAyzRGyAhzRnHmzrdPXlJ+FhF72yviEMUdTZU3GPYWkuXZ65ruWAp1O5YvXww7BH
 Enm6JJOO2Qassi8lo9iag==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:8/ow47NcKJ0=:ALFme0/z/q+EBOLDbdC/Ma
 D/EQ0soTZuGiUCWo6/S97hCa2N3yk3loeuFctWIb228iKZVWUqMUfsf7HNFR/BvzmIs+KYYB8
 m8H/YaVzJJL/yK4AgTwsf0ni87s9XBHbKAOSQIvicOaFFw3KMCE/K44NYByencZmdDPYB+VEa
 CSS0HStyqOJbiFOlfQUS503bpcTm4kB2K8CDSNEHdHHdCwOCkNcTlUaISgYRxU3gaj+c1lQSM
 XqX9SH37kqNLzaYHhXXBG16FZzngtK6Is1HNpHGz9dvifMsnK7AAp5KTbpaR8YqVjWzIeaWyK
 7tMEgThIjzVnQVdFfUXGhpV2yDanaYEh3md8zAAFa4+EQTIAiiJamTkmQzIGfXPEroh+ARqsi
 Teh/9cXnRM+A775WKEu+U0FUueuUdE/Zn1R8LQsJB4QHw6VIDc22hQPwzevo6BLprMf3rNQYF
 F8dPq/s0hB9IiRtsBKLthTRkpp42G9T1BAs0yRXIZFq6+Ao7vsJdFjTT+w6sVivbaMHPspMuQ
 hPowN2VRL5ChrMuDOauF4468g6H/UV/SRpZzcOAMnFk7B1Qbqw0herCdgEYjl8Zmprihm30sm
 Z1g5MS02PAqX/pW/IljlpXqY4Gkvx85y+2L1qNMe2MS5/cv4gE9VBjxJBK2j0s3wT5BA8bLDB
 eH7hiB19x9FcZdY8tHUIP0qtmK826NkQKYsEE4vnjo3Q4wb8ZbaSh2PBXcJyKrESoN0hPStcV
 bxPvmuHxCB4SsgwmbIOCEiy8cStupMAwAWGrnp5gJc8agVs981uj40OGx+53ACMC5i48uOQFC
 KKB1P+V
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Definitely keep that paragraph. I am quite familiar with the test
> > helper and it was not the outcome I initially expected.
> >
> >> +test_lazy_prereq 64BIT_TIME '
> >> +	case "$(test-date show:iso 9999999999)" in
> >> +	*" -> 2038-"*)
> >> +		# on this platform, unsigned long is 32-bit, i.e. not large enough
> >> +		false
> >
> > I see you tightened up the match a little. TBH, I think we could
> > probably just match the whole output string, but I doubt there's much
> > chance of a false positive either way.
> 
> Ah, it wasn't meant to be a tightening; rather the above is for
> documentation value, i.e. make it stand out what 2038 we are
> matching---its answer being "the year portion of the result of the
> conversion".

How about this one instead (which is part of the time_t-may-be-int64
branch on https://github.com/dscho/git which I still have to complete, as
some unsigned longs still slipped out of my previous net)? It strikes me
as much more robust:

-- snipsnap --
From abe59dbb2235bb1d7aad8e78a66e196acb372ec8 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 12 Jul 2016 13:19:53 +0200
Subject: [PATCH] t0006: dates absurdly far require a 64-bit data type

Git's source code refers to timestamps as unsigned longs. On 32-bit
platforms, as well as on Windows, unsigned long is not large enough to
capture dates that are "absurdly far in the future".

Let's skip those tests if we know they cannot succeed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-date.c | 5 ++++-
 t/t0006-date.sh      | 6 +++---
 t/test-lib.sh        | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index d9ab360..1e12d93 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -4,7 +4,8 @@ static const char *usage_msg = "\n"
 "  test-date relative [time_t]...\n"
 "  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
-"  test-date approxidate [date]...\n";
+"  test-date approxidate [date]...\n"
+"  test-date is64bit\n";
 
 static void show_relative_dates(char **argv, struct timeval *now)
 {
@@ -93,6 +94,8 @@ int main(int argc, char **argv)
 		parse_dates(argv+1, &now);
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
+	else if (!strcmp(*argv, "is64bit"))
+		return sizeof(unsigned long) == 8 ? 0 : 1;
 	else
 		usage(usage_msg);
 	return 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 04ce535..52f6b62 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -31,7 +31,7 @@ check_show () {
 	format=$1
 	time=$2
 	expect=$3
-	test_expect_${4:-success} "show date ($format:$time)" '
+	test_expect_success $4 "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
 		test-date show:$format "$time" >actual &&
 		test_cmp expect actual
@@ -50,8 +50,8 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" 64BITTIME
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" 64BITTIME
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..4e1afb0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1111,3 +1111,5 @@ run_with_limited_cmdline () {
 }
 
 test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
+
+test_lazy_prereq 64BITTIME 'test-date is64bit'
-- 
2.9.0.278.g1caae67

