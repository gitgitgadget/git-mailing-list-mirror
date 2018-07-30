Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD0A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 13:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeG3OvS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:51:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:59489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeG3OvS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:51:18 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3zG2-1g1NhU2DEw-00rUmD; Mon, 30
 Jul 2018 15:16:14 +0200
Date:   Mon, 30 Jul 2018 15:16:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: range-diff, was Re: What's cooking in git.git (Jul 2018, #03; Wed,
 25)
In-Reply-To: <xmqqd0v8oaf5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807301510370.10478@tvgsbejvaqbjf.bet>
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com> <87fu0469d1.fsf@evledraar.gmail.com> <xmqqd0v8oaf5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1040895061-1532956574=:10478"
X-Provags-ID: V03:K1:+ThkdoBWKgxkZJdMvYWzvJtgHTDELEMWvl0vDIPf+RLPsvuAhvt
 90bCy5K9oxVMX8VvDw8XnAEUSaDVqgzNqExPrLrWCREhgJpZRIVSLKbUx6s4RY+4Lcbws/d
 7YNCYrr17zoayO2a5g/bvmAl2M9v4ua8H+NI1tXdlC1rhme5NXaCcR/36OsTyiIImc3U9dW
 UNTxYQlzUbe8xcyDuGKNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U/O4k+4CEqg=:lyhDM8SXoSzQBwHHXAduEy
 iblnZkH/HxKBg9yArKjBe+QFQQW9OC/JdAb+zTAh3g2QxRN81dXRjBpqIS3KsodM1AHqZE8/3
 ppJUPzFAH/H9ORpbtrclaNpUfPLChBHPizrU9lue4EsdUdgU/puvyw1T8yljGkI42LvynME+h
 06m2XWGRLZ7nsXKmckhN5Nso1IXD658CkcCrYS0PYON/KqqnZnlFoZQNKvxW+181zwbfG6tnF
 ULha2PRT3LcYv7gqjVVvGej9WElDd/G5Z+geI3nQyYQpcSsutjWCLmVcZwiCgtstIkcGNb5Ra
 rmONMIqdU8EAff2jeCZ/UDGFlbR7dN2Uup7jz3wLOgAh6wVszYdoxffHgBxZZIq0qOK5siQor
 c8LnjjDZW4k97GZGb1J1/3ss+MBKl89ZNt75DATvrU2G3UcMnLTqRmuMKkY6SCELOSINdI7qG
 HEdJOr0TVsubneJT2t5IM3govnm6F72ox9CVZ4Jn3O+jspdSFqNJyPTUBgVn18jZZr0+X3IzL
 PpOoNmNwMAf6zo8SUEISVCbeKLKr8aaIquN6HwEBo3eGUMwzxCfVnVKJMU7gw2XyUlTAVoLsV
 DM7Zq+UvUSMKJIIYuNkQ9lMw8rtGQXKbhcSZ13K9v8vE8psdV5lyRripcqXEKlBVgjAHUFciY
 o4P/WaTW+9Ypb264eeuXznhANh8XfRTR5s5aBM+9K9Olln2zIocp7kaHWID1bryFA7nkJCL3z
 r+aT2qGJu7DGnW2V8WjTo2KRCcGJNPL4I6fuF3jdz3xQqcNMXrE9vl2CEhfEQnICHLYZkkObR
 sANPEpV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1040895061-1532956574=:10478
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Fri, 27 Jul 2018, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > Count me in the "this is useful" camp, but also I did look at the lates=
t
> > submission this time around, but had nothing to say, so I didn't say
> > anything :)
>=20
> Please make it a habit to do say something to show that you did
> carefully review the series especially in such a case, which helps
> to differentiate a change that is interesting to nobody, and one
> that is so obviously well done that there is nothing to add. =20
>=20
> What I have been doing from time to time, when I think there is
> nothing bad in particular to point out, is to quote a part that is
> especially tricky to get right and think it aloud to show how I
> would reason why the result of the change is correct.  This type of
> review helps in two and a half ways:
>=20
>  (1) We can see a correction to what the reviewer said, which could
>      lead to further improvement ("no, the code does not quite work
>      that way, so it is still buggy", or "no, the code does not work
>      that way, but triggering that bug is impossible because the
>      caller high above will not call us in that case", etc.),
>=20
>  (2) The reviewer can demonstrate to others that s/he understands
>      the area being touched well enough to explain how it works
>      correctly, and a "looks good to me" comment from the reviewer
>      on that change becomes more credible than a mere "looked good
>      and I have nothing else to add".
>=20
> Thanks.

FWIW I picked up your Asciidoc-underline fix, and I also fixed a typo in a
commit message (you may want to pick that up, too, unless you want me to
send a full new iteration, I don't care either way):

-- snipsnap --
11:  bf0a5879361 ! 11:  0c1f5db5d01 range-diff: add tests
    @@ -3,7 +3,7 @@
         range-diff: add tests
    =20
         These are essentially lifted from https://github.com/trast/tbdiff,=
 with
    -    light touch-ups to account for the command now being names `git
    +    light touch-ups to account for the command now being named `git
         range-diff`.
    =20
         Apart from renaming `tbdiff` to `range-diff`, only one test case n=
eeded
--8323328-1040895061-1532956574=:10478--
