Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345B61F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfJNLSL (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 07:18:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:34715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfJNLSL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 07:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571051885;
        bh=1yaofTn9rfnBksnQjRmjs207NvrEE3OcxZAyWby7Ohk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Rnef4V1IOEBMnZJJBcOydfHUbF3qLfi35iMb5NcsK1GA5rPufoKaW+SuyFFScqjMk
         mKetTifxMPJ9ANeoQxHIRU+brGn02bsKgjthp7mpL3AbeWo2lIZAlEnz/6R4kCNdCV
         pTq9iy7LusxY4ASq7pTbLHG/UN7SD04ERdh104Pk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1i1cYz45Bd-00sRPD; Mon, 14
 Oct 2019 13:18:05 +0200
Date:   Mon, 14 Oct 2019 13:17:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     kdnakt via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        kdnakt <a.kid.1985@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: [PATCH 1/1] Improve Japanese translation
In-Reply-To: <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910141317190.46@tvgsbejvaqbjf.bet>
References: <pull.396.git.1571016698.gitgitgadget@gmail.com> <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1573521775-1571051885=:46"
X-Provags-ID: V03:K1:1UxWWqrxrG52bgVMhJp0WEJEyAz5q86uYAXCboS3mBVfak/mIx/
 Hfbnkn4uMSHlguAJfAwlTNQ7mvHqOO8SnFfyMVDGISLz5tg6TBHqrxnAWY9UVxLz+HXSXuL
 iZF5yPyML5/3x8cYKULd/3adJgmNoeLy9ak8SYgtdz8vgd5VzzlPgoVWLkXF5X5k6iwUrBw
 LwyU9joKhpaCDkfspF86w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XShrCEEDQtQ=:TuI1mPtQzJPNEPAPGVJimS
 Xe/FuudlLc2Uq4yBe9iQz+1rquwzwMnX96KfNn/WKWwZC3FglZjC+u4YQoU5EnuTwGgiyYKAK
 R+HZFmP2l8x4LSrW+mxAV89GaSqCclguIojKb8a/7RfJtQmI2BmvEBEMsnjmIedHuzAQK5JPv
 RXL+5uAUTYOvW3yvCY2JTgxApjG+Xc5B4H5hw+IiCw6gmwDUAJnvPLjrhVhu1jDZYjcXvcXvm
 4LR653puc8JiI4E20uj55jlcQ+9lUiOYfgT1zUQJzliRoRQ8YqWUcyRXp9oxLoRfzrt6ZBApq
 iPFnf55BTSxusmUYhazvIjYI1ug4uzBTBZeSpsBCeyA7Ic+xWN8PBA/cqETsDPc40ZMWNl65S
 ayYZQb1BQS20t58NT47OYE7tInYM41O1BZhZm3+cAUTuWW1FMNrXtPIp4+lLG/myEp+31Q+OZ
 MHs3lzq4IODheHPl/E7KBzn+SinGHTE1Q4ffIro5G2iBCNL2IOKXLbRIDQZaFuvgSIV4VDwA7
 USvU3vX840+ONI46caGJ75/hc9X4zXRz9qQMrsWFIHMmeumEECeAcRzeYkO/h9HMl8G1gXLYj
 gDHGb26yPUiQcBTSalhJn7GBaXEY8URycx7xQyDLQuKMrI5FcxpYIm4WeycK2h/ecj3dgrqsX
 kbQD2kLThalr38uGU98+q3fUv/wMx5/zKAtOKc/R04SrpQyF4jNfGnB16QIiMuM4fFuAB4xcP
 EIFuN5vWWiArsu1UjWQs0HWMBYftWJDjSwePzxtIn4Pfb4137QIVkbIrpZthZOOlQMyFUI7VR
 SY0p6EPcQAEoFXdm6u+tRvRzG43PBd27i+Elaz80F9jmw0cgpHqrRkqESe5zJ2hkninheQdKM
 P1WG/uCIwsV54AhYXdGgYV+3GJgmFcAM/bNJbxBM9zLfRTp6e/2Er3Eop0KDqYAS2r/TaPM1K
 SUUJZ7Iz0jOoc6nMUaJTTdZbD0Fs2BqPfXpWiEuZqDMsV95UoMnvHJ8411YuKhW/PK7uDyr43
 Ds4PR3FOExLkgG9wM4KZ6SM5rzq1Xe89c5e/Yp5rbfJotXkuQ9Aehpk+HqnwydAjMeK/vSOuN
 RO/A8dUcOSQSs5rQbtxt9NWF4ooDZ4WZJoXXi3T6+HQa2BuGL+/2Tsv7zQVP8lfmf+c76VjjI
 Cgqu5dGO/P55pBQQN2cBTAajjl8bV+RhdB9frrWledAbTZ4AWwJz22pBWPAv0ghnjJFtg0+ti
 oZUezX26AayOgmbIvKM3Fkud/iN4G7RTWFjfaCWaYDFUiVG9MrnUsg797Qy0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1573521775-1571051885=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[Cc:ing the Git GUI maintainer]


On Mon, 14 Oct 2019, kdnakt via GitGitGadget wrote:

> From: kdnakt <a.kid.1985@gmail.com>
>
> Signed-off-by: kdnakt <a.kid.1985@gmail.com>
> ---
>  git-gui/po/ja.po | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
> index 208651c1af..2f61153ab9 100644
> --- a/git-gui/po/ja.po
> +++ b/git-gui/po/ja.po
> @@ -4,14 +4,15 @@
>  #
>  # =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=81=93 <nan=
ako3@bluebottle.com>, 2007.
>  # Satoshi Yasushima <s.yasushima@gmail.com>, 2016.
> +# KIDANI Akito <a.kid.1985@gmail.com>, 2019.
>  #
>  msgid ""
>  msgstr ""
>  "Project-Id-Version: git-gui\n"
>  "Report-Msgid-Bugs-To: \n"
>  "POT-Creation-Date: 2016-05-27 17:52+0900\n"
> -"PO-Revision-Date: 2016-06-22 12:50+0900\n"
> -"Last-Translator: Satoshi Yasushima <s.yasushima@gmail.com>\n"
> +"PO-Revision-Date: 2019-10-13 23:20+0900\n"
> +"Last-Translator: KIDANI Akito <a.kid.1985@gmail.com>\n"
>  "Language-Team: Japanese\n"
>  "Language: ja\n"
>  "MIME-Version: 1.0\n"
> @@ -661,7 +662,7 @@ msgstr ""
>  #: lib/merge.tcl:108
>  #, tcl-format
>  msgid "%s of %s"
> -msgstr "%s =E3=81=AE %s =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
> +msgstr "%2$s =E3=81=AE %1$s =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
>
>  #: lib/merge.tcl:122
>  #, tcl-format
> @@ -956,7 +957,7 @@ msgstr "=E3=82=A8=E3=83=A9=E3=83=BC: =E3=82=B3=E3=83=
=9E=E3=83=B3=E3=83=89=E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F"
>  #: lib/checkout_op.tcl:85
>  #, tcl-format
>  msgid "Fetching %s from %s"
> -msgstr "%s =E3=81=8B=E3=82=89 %s =E3=82=92=E3=83=95=E3=82=A7=E3=83=83=
=E3=83=81=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
> +msgstr "%2$s =E3=81=8B=E3=82=89 %1$s =E3=82=92=E3=83=95=E3=82=A7=E3=83=
=83=E3=83=81=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
>
>  #: lib/checkout_op.tcl:133
>  #, tcl-format
> --
> gitgitgadget
>

--8323328-1573521775-1571051885=:46--
