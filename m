Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106241F404
	for <e@80x24.org>; Mon, 26 Mar 2018 15:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeCZP2G (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 11:28:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:54581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeCZP2F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 11:28:05 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFgxF-1eo85Z49kD-00EcFG; Mon, 26
 Mar 2018 17:27:57 +0200
Date:   Mon, 26 Mar 2018 17:27:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/36] t/helper: add an empty test-tool program
In-Reply-To: <20180324074505.19100-2-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803261722350.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com> <20180324074505.19100-2-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1412799066-1522078077=:77"
X-Provags-ID: V03:K0:VXW8wWfho9TuB1V7oS70xia8dkqeM3v1X99yqMpNofUT0V9nQn/
 5yImlOscEXrrnEAMdKJos9qbJI10Y2Bl44H6Q5jc7yo4+ZT7ZmAT3iRMnikZNkwLnILmYAT
 1Lu7Mmgf+hndj+PdxUiinIsR2A7tLB8mbEtwpUkifH0N62Wkco2WVp50ZBqSjAzNiNWd+DX
 34KotRLPtIJMVpjZCAiaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AqoYuMb8x2Q=:i+MQCgn3YbwOIE3cPIX5he
 tPdGuSLlZvwdL3543PxA4yd1tYgSYDHl+fUSTlwqEor7KkOdyQGowVd0Qk7aBhgiw7NXGWjIu
 y4N6WTvDM/ho5aAUOeh6QLJ1hyMctJONdJwdzwS3ozj/7tDrbxTWsMEOh+LHqK46uLz50kdgv
 vgx3rk1R5Rdm4RFIvfzrWTaeUadduWYo2NNiYTtaRx15tG5aF2kjb5Aa9sfvUECpP8qiWt4mC
 cp6cUe/XmKPnnCQS/DeU71YmyXZ4TITTqVOn82VbtOOCnA9VfN92Fo+9EX93NLBBEGKQtsTb8
 5MDxuJpLrG64Ww4K3qNlANHMdpxCJkbqMFwN1y8JyleWUSBI7WcRzRY8+f/0L8TQFcYWzoZRS
 q3g096mKTNEQ7u1k+aT70nu1XUpkHBfxWEdRpurkmtFVpTnExSphnsBIiV0EtlCOQd6vRKwyn
 aog3u0BM1Rp7wSsYA0HeQKSK8M7dJYGVD4suBl5Ji2omo1Vtl2wLu7BwBScfYTNV8HFTWEc32
 v5/KNrWI9gnc/1RZWIFctb0j9TQyXCMbS1aDzsOnEgINxYPQyr8giQoPjyjRy26UvZdgDREzY
 GxlhknJM7K5/j7Z6YV6mpO+dQsQui20MMPqPkvBOx4SISJNJrt4ouQKGZNClOdfngmM81z4Gk
 cO7PCHy2Fs8lQAKrpFGoLGBQUYsehRGBUyYqlFlq56HinnFDc4u+L/FMNWqi/rdJuNALGRj5k
 WjC8IoR7PsG9EBjrpEQi7eyNBbltuUmBrqcW8wRGEc8Af5rUthNAdH65f2rEu+xDgnYRBROKI
 UCxHCiiN/iPfa1sG7dKNFr487n3e+K0CBI6hNb9oalkHFN+VVgg951m/+lYwDyJ9CMOn6S1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1412799066-1522078077=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Sat, 24 Mar 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> new file mode 100644
> index 0000000000..c730f718ca
> --- /dev/null
> +++ b/t/helper/test-tool.c
> @@ -0,0 +1,27 @@
> +#include "git-compat-util.h"
> +#include "test-tool.h"
> +
> +struct test_cmd {
> +=09const char *name;
> +=09int (*main)(int argc, const char **argv);

This makes the build fail on Windows, as we override `main` in
compat/mingw.h:

=09/*
=09 * A replacement of main() that adds win32 specific initialization.
=09 */

=09void mingw_startup(void);
=09#define main(c,v) dummy_decl_mingw_main(void); \
=09static int mingw_main(c,v); \
=09int main(int argc, const char **argv) \
=09{ \
=09=09mingw_startup(); \
=09=09return mingw_main(__argc, (void *)__argv); \
=09} \
=09static int mingw_main(c,v)


I know, I know, now that common-main.c is a thing, we could simply pluck a
`platform_specific_pre_main()` or some such, which is overridden in
compat/mingw.h to `mingw_startup` and to a no-op in git-compat-util.h as a
fall-back.

The truth is: I simply did not get around to doing this yet.

In the meantime, could we have this SQUASH???, please?

-- snipsnap --
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index cd5e28b045a..87066ced62a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -3,7 +3,7 @@
=20
 struct test_cmd {
 =09const char *name;
-=09int (*main)(int argc, const char **argv);
+=09int (*fn)(int argc, const char **argv);
 };
=20
 static struct test_cmd cmds[] =3D {
@@ -55,7 +55,7 @@ int cmd_main(int argc, const char **argv)
 =09=09if (!strcmp(cmds[i].name, argv[1])) {
 =09=09=09argv++;
 =09=09=09argc--;
-=09=09=09return cmds[i].main(argc, argv);
+=09=09=09return cmds[i].fn(argc, argv);
 =09=09}
 =09}
 =09die("There is no test named '%s'", argv[1]);

--8323329-1412799066-1522078077=:77--
