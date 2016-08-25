Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB55D1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 14:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934455AbcHYOAJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 10:00:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:61661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934202AbcHYOAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 10:00:08 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNIAz-1bWZPo0zH7-006tFD; Thu, 25 Aug 2016 16:00:05
 +0200
Date:   Thu, 25 Aug 2016 16:00:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: [ANNOUNCE] Git for Windows 2.9.3(2)
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-644592451-1472133605=:4924"
Message-ID: <0MGSgq-1bPfeP1Rmi-00DEuI@mail.gmx.com>
X-Provags-ID: V03:K0:39DVVJldy4exy9x39hVkPmzjls1fku4iI3ybFNVxNnw+raImSMd
 CFQmdt1LT+tmdKHqQJaySVWJJQMlQInFD8j4e1H8gfm3P6vjuByQ0e24PJIuaHplVmnjghU
 qFq4ThtQf6MySm/ldb8pIt1LGQ/w5HI9A1u5gXDxRs7FfnTntSxWgi1p4WYa4Vzlux1hbvS
 KDaQFn7TyMwwq0TGD3+XA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LnrkbdICJ5c=:zbqwLtIdeJIWVn2SlWiMMt
 e2YFlKiLf6i13oMqON50hmtVoWq3nDNlBV8l9gudRr3fAzs5AY/dwV/a6Tt7S0ZDSqLcP0MzS
 kbIfEdyO/kP8hvr7tngsFxt1Juz6Gpw2QONhP2bXxaLWDL5jq62HP9iKaoJDRF34tfa9HarEr
 rXYXNbrN4jjIBipQWEZmptokmqBt6Zyc0WHiwO++jQd3VR/rSmAIzmGDbpQa6CpqzA9jxKSZ2
 5nPl8zjF1OwALKnw84OpkAJd6CeR/xEoWveQz7CEE01j25qoZQM3E6Aq8etWxk8H7WiCJyDmA
 HS6wk0PbFl7aEORRM4WyfeqXVoXXC+HhIsADgC4Og6fQppmDB7A8DHdUsUapfa9ZfNXlYkcfH
 FkJEPW3p02Vhln7rfXM1qzvVPv/pX8NS7WWqeX+Xmeyt8sYPg4WcQMtflY+UG7n6AOS7iJbza
 UxNtYdtI2XbK8rKoGuhxk+1AxsFAiedIVGH5z4V2/E8x7J28txvvH93jDu4HudKSsnuPH7eVJ
 qEGizLqpIIPjn3ju91SruaIpmNpN3jceNRBB6KNibL6lZa6TpNQT/hXloGwcOzb0vmRoY2PCb
 uiCuEOYYBSAFW6B8TBZuVNax8nJA3duyHnlV8OF/wjMSv5PeK7LJK8iBhs2FnuBW9pX9JV4Yp
 WnRdvd8whX3GtdEN+jtWBEwAUln2iP7aQxycDKwgGMOtttj5MXS45uCXzcvRJATDXx0aAcKR+
 11cApPfGfA3WOZcWJPEGFKqXSamIHjO1WjITkll9V7p0+nTug5TgaaiNCAghH/3peT8ZqoNVy
 WqFYUsl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-644592451-1472133605=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.9.3(2) is available fr=
om:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.9.3 (August 13th 2016)

New Features

  =E2=80=A2 Comes with Git Credential Manager v1.6.1.
  =E2=80=A2 The feature introduced with Git for Windows v2.9.3 where cat-fi=
le
    can apply smudge filters was renamed to --filters and made
    compatible with the --batch mode (the former option name --smudge
    has been deprecated and will go away in v2.10.0).
  =E2=80=A2 Comes with OpenSSH 7.3p1.
  =E2=80=A2 Git's .exe files are now code-signed, helping with performance =
when
    being run with Windows File Protection.

Filename | SHA-256
-------- | -------
Git-2.9.3.2-64-bit.exe | d23629ec9f89a6bbddc0459108296b4fdfa08abd98e0748513=
4a9a30ad40486a
Git-2.9.3.2-32-bit.exe | 7d9645093925fee8de5308c7d6d53d9f6b070e95e4369fef02=
b4493da782475f
PortableGit-2.9.3.2-64-bit.7z.exe | 2115cbd45b20efc62dcfa57ce86d5b6f3f15e8a=
887f253baeb43e3bff836810e
PortableGit-2.9.3.2-32-bit.7z.exe | a173516ba51d7b1d926b78243911c55962c007c=
c6ea822d1cca37963a4794c68
MinGit-2.9.3.2-64-bit.zip | 4616ef2cef84d19ccc0325d6326107fe82a7c487dafbe7e=
e2248878cea32ea1a
MinGit-2.9.3.2-32-bit.zip | 7178963b663d91abc5d101eab6a24552fdbc2913a312eda=
a8291266451bcf1d1
Git-2.9.3.2-64-bit.tar.bz2 | 9cbb3019bc614fa2769b6d64298b339a2ef66d475602c1=
d572b849283b62ad15
Git-2.9.3.2-32-bit.tar.bz2 | be55791fbd02bd7d51b7b93eed0ac8193bbd996e8590f0=
f0ac01b65c9a85e5b0

Ciao,
Johannes
--8323329-644592451-1472133605=:4924--
