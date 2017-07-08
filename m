Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B22202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 16:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbdGHQoA (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 12:44:00 -0400
Received: from mout.web.de ([212.227.15.3]:54913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752797AbdGHQn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 12:43:59 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC1VQ-1dL7OB2kQi-008thV; Sat, 08
 Jul 2017 18:43:43 +0200
Subject: =?UTF-8?Q?Re:_0_bytes/s_vs._=e2=88=9e_bytes/s?=
To:     =?UTF-8?B?56mN5Li55bC8IERhbiBKYWNvYnNvbg==?= <jidanni@jidanni.org>,
        git@vger.kernel.org
References: <87lgo02qat.fsf@jidanni.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2ac080ed-57aa-5492-8887-4421c50cf3cd@web.de>
Date:   Sat, 8 Jul 2017 18:43:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <87lgo02qat.fsf@jidanni.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hQRO0+KCe9JZtz4J/kIXrGszr85IUkpWgDSnhbHu612bJQjRt7i
 J1Krz+QoQaxdgXPkRuzLUMkqnj0u2ux/9Eh6GQaW7Cwj5Ta9sgeSBh4TpaGWgybDpY6Js5c
 xnky6wPXy+UGMokCnofmifZsVMz8ZfSX/olj4htJ1+SUTtBd1uSxHnnocTo1bnsbpOYEShL
 b7uA+Tj6f0U10in/zbxNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v+4wNLDSt+M=:e1kQg9H1pu1rSbW/K+1pgI
 Khk4hiaQbq5vX2QhVSZii+Un9x9cVwl+ZoDe3maPk7v0MGospBp97IOnJ5qiOlnaamTXZUsn2
 Qacj3wcWpZEtvXkZyq0lIb9pA0xXX4N0wdzjpwzn9IC9ZeT55vHtVBy7zUJuxkflJFZ9C1q0I
 fak8LWEtsw1zDE1o8xxS+Yq2VJ5BNIE0wy/gOI7M2YMEbQyAVn4KZU7MdQOJ+76DMxD+JNsFQ
 gYBynikxF0r2fpN7F2sAdGh25LvJzszPCQoD5iYp2nMYRXIrZid28jpBDzgHGvWdH2Q5Zqv25
 YBbIf1nKwHJ76rtvqk6AsrWUPEi2TA3e3gV9OunkqOL61LOiNZnVJyykBpNsYiaokOGqKvtGy
 VLrCRFywiFWdbjoifnxUywvghRt8im6RKuuq8RrHP+Z+q4iFXi4SiiuRcFjpDpWtHVJryDhEM
 rlqgfQ4/oV1NKp6frThVTfUx6rgCbet06BjMlz4OjaNeZgnj5YEWM/qiIptuqmcvT9STvMs0+
 6+IljPlYC9BI5lePE0r4/b3Sp0iScL/ZKSKXW25OwT9D2qn7A3+0mQvX3k4ecXLj4FDnyfdxW
 +cSj6tDiuMncHu0uYGjLbgH8rLUVkdneFCoOKlshLEtWE4j1nQkfUWgdYrq1mgwsr6uY41F/T
 KC0T1s4DpUuBdXgMqIf8763e9QRkICE6Cwbyz72jhwYB9uG3dQ61mglnJJbBxnLsBxFF8MZS+
 gDJcmV+JRAYvBiC3zFlfWHnSChggOlLycOPXatchDhOVtdUpuy9rQ0miJ82Gnt5YegpX1W5Il
 FB1FxIn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.07.2017 um 17:57 schrieb 積丹尼 Dan Jacobson:
> Receiving objects: 100% (1003/1003), 1.15 MiB | 0 bytes/s, done.
> Receiving objects: 100% (1861/1861), 11.74 MiB | 4.58 MiB/s, done.
> Receiving objects: 100% (474/474), 160.72 KiB | 0 bytes/s, done.
> Receiving objects: 100% (7190/7190), 26.02 MiB | 6.53 MiB/s, done.
> 
> If the connection is too fast to calculate, please report
> ∞ bytes/s or
> inf bytes/s or
> ? bytes/s or
> anything but 0 bytes/s, which means nothing (transmitted.)

I don't know your actual transfer rate, but I would guess it's closer to
zero than to infinity. :)

How about this, though:

-- >8 --
Subject: [PATCH] progress: show overall rate in last update

The values in struct throughput are only updated every 0.5 seconds.  If
we're all done before that time span then the final update will show a
rate of 0 bytes/s, which is misleading if some bytes had been handled.
Remember the start time and show the total throughput instead.

And avoid division by zero by enforcing a minimum time span value of 1
(unit: 1/1024th of a second).  That makes the resulting rate an
underestimation, but it's closer to the actual value than the currently
shown 0 bytes/s.

Reported-by: 積丹尼 Dan Jacobson <jidanni@jidanni.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 progress.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 29378caa05..73e36d4a42 100644
--- a/progress.c
+++ b/progress.c
@@ -36,6 +36,7 @@ struct progress {
 	unsigned delay;
 	unsigned delayed_percent_treshold;
 	struct throughput *throughput;
+	uint64_t start_ns;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -221,6 +222,7 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 	progress->delayed_percent_treshold = percent_treshold;
 	progress->delay = delay;
 	progress->throughput = NULL;
+	progress->start_ns = getnanotime();
 	set_progress_signal();
 	return progress;
 }
@@ -247,8 +249,10 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		struct throughput *tp = progress->throughput;
 
 		if (tp) {
-			unsigned int rate = !tp->avg_misecs ? 0 :
-					tp->avg_bytes / tp->avg_misecs;
+			uint64_t now_ns = getnanotime();
+			unsigned int misecs, rate;
+			misecs = ((now_ns - progress->start_ns) * 4398) >> 32;
+			rate = tp->curr_total / (misecs ? misecs : 1);
 			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
-- 
2.13.2
