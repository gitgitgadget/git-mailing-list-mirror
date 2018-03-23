Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A191F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 09:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeCWJm6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 05:42:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:52507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbeCWJm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 05:42:57 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqV4f-1eLrrh3uNt-00e0qQ; Fri, 23
 Mar 2018 10:42:53 +0100
Date:   Fri, 23 Mar 2018 10:42:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     John Chesshir <John.Chesshir@mindbodyonline.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: UriFormatException output when interacting with a Git server
In-Reply-To: <DM5PR05MB35484CC117C6E758F520600994A90@DM5PR05MB3548.namprd05.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.1803231039490.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <DM5PR05MB35484CC117C6E758F520600994A90@DM5PR05MB3548.namprd05.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1273028567-1521798174=:77"
X-Provags-ID: V03:K0:diahThCD/rtGivTYizoYOk59eVI/OrhTIu4sriW1HVgB1xv5AK/
 XrirJRMI0tW5zY9W/VT3dsLEM7GkpWqxvbY8sSRvARIdr7Vqw79KdtfWrLINTGvyd5Tf+z3
 4s9CCYB3nBK3TLvtlqU2RYqekKaz4eAGgdpaQpgy+Ek4LlNPdLvHf/7O2svdcdqceILEwkv
 9njsYm+zz04FoPUpaKgyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3xs/F0nlSnY=:FgYXrDAR3g3NPS1wy3r11g
 Wk/71wMjWRIG2gBdFT8nkGjCA0+25E5RD8gabf2xQGWk9VH1ItMBdRyrSnMjJ3ry7KNd2eWql
 jYNvZNsATvz3qdmzbsc7oyipF1roRO/wNSSzFKlF2rRJysfpNLsP1W07tuvz5v9dyFU+853nV
 p9K08RqJ3oMHJHyjQhZq8JpaVVKIXUYkUjxDvpsOv01sfZ6kWpK+t+jOM03mUoXSXdkYcQ+aK
 A0At/e9VeL5s5mKoIyZ92uF8L/7eJ9I/5kCkMwCN5Gf8V9yF4lpNGllzOCZRASDfHT37MH2P9
 JbimA0miXDYxWg3i4u3UtK+eZZINDA3iD4J+U1x5oYNKNLgOCt7k6gAD2CM68N5oe5ieVIFGG
 Fzzk5oxsoCsgOyeww2yxF72rPM4lt83uhmmHGlPGgTtBcpieyzz/rnPEeg8v+0T+/1/U54VqR
 CzaWfD2B+2cYMB0GtxtnhrVvZXcxIXU2MT0K9Qrm73OS9nBX7j9BA1+rfU9Rm5NF12IVxLgQA
 WRk23x3LP5TOqpbLa9rHU4Ov75WVtbQbwuOhmHmwUwMdLMuE0QBJ13WAxNuiKzQhHEax+aSU4
 /rG+FhTSVL2+hseGJ87cq4i4PpcyAZWsbQIMGB+2oJl6JTQ5NjKW4qnJ7l/C+FKyyKvLKVYiE
 5/Sb/qWTGtIrJS/avhPi5ghzLsNDYxkryB5HVWLnINBJ6CF+JZgFeb25KZBQ8yKtJTD4X4ncw
 tWrzeIyiHF0/bJeC8U5B4IRovSZH5C4iMbVE5ZfXhCS7yZxmSzRowBO3aVa79sBtabyFlZkkv
 QHhc7660rTMiYrXqu5vz8L2aPdqhnn0OolKYC9+NVu4aJtb7Yc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1273028567-1521798174=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi John,

On Thu, 22 Mar 2018, John Chesshir wrote:

> I'm getting this error on a fresh install of git version 2.16.2.windows.1=
:
>=20
> fatal: UriFormatException encountered.
> =C2=A0=C2=A0 queryUrl

Thank you for posting this report.

I would like to ask for more information, though. Ideally, open a bug
report at https://github.com/git-for-windows/git/issues/new which has a
template to fill out the most important information.

In particular, I would like to know

- what command you ran, and
- whether you have a reliable reproducer

> See this post I found,
> https://stackoverflow.com/questions/48775400/git-fatal-uriformatexception=
-encountered-actualurl
> for more details.=C2=A0 Note that the latest comments are mine, and descr=
ibe
> the conditions on which I first saw the problem.=C2=A0 I'll warn you, it'=
s
> weird.

If this is a bug in Git (or more likely in Git Credential Manager, judging
by the error message), you are more likely to receive assistance in fixing
that bug on the special-purpose bug tracker on GitHub.

Ciao,
Johannes
--8323329-1273028567-1521798174=:77--
