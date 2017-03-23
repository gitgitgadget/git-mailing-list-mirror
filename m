Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6660E1FC19
	for <e@80x24.org>; Thu, 23 Mar 2017 11:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdCWLDM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 07:03:12 -0400
Received: from kerckhoffs.g10code.com ([217.69.77.222]:33537 "EHLO
        kerckhoffs.g10code.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbdCWLDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 07:03:11 -0400
Received: from uucp by kerckhoffs.g10code.com with local-rmail (Exim 4.84_2 #1 (Debian))
        id 1cr0WL-0005yo-Fz
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 12:03:09 +0100
Received: from wk by wheatstone.g10code.de with local (Exim 4.84 #3 (Debian))
        id 1cr0Pk-0005F7-Ll; Thu, 23 Mar 2017 11:56:20 +0100
From:   Werner Koch <wk@gnupg.org>
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Stable GnuPG interface, git should use GPGME
References: <201703101100.15214.bernhard.reiter@intevation.de>
        <201703171056.10468.bernhard.reiter@intevation.de>
        <87poh9p70n.fsf@wheatstone.g10code.de>
        <201703230829.40741.bernhard.reiter@intevation.de>
Organisation: The GnuPG Project
X-message-flag: Mails containing HTML will not be read!
         Please send only plain text.
OpenPGP: url=https://k.gnupg.net/80615870F5BAD690333686D0F2AD85AC1E42B367
Mail-Followup-To: "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Michael J Gruber <git@drmicha.warpmail.net>, =?utf-8?B?w4Z2YXIgQXJuZmo=?=
 =?utf-8?B?w7Zyw7A=?= Bjarmason
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Mar 2017 11:56:14 +0100
In-Reply-To: <201703230829.40741.bernhard.reiter@intevation.de> (Bernhard
        E. Reiter's message of "Thu, 23 Mar 2017 08:29:31 +0100")
Message-ID: <87shm4mfch.fsf@wheatstone.g10code.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=ANZUS_CDC_Roswell_defense_information_warfare_bluebird_AMW_PET=Uzbek";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=ANZUS_CDC_Roswell_defense_information_warfare_bluebird_AMW_PET=Uzbek
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2017 08:29, bernhard.reiter@intevation.de said:

> I was under the impression (and I do remember you telling me a few times)
> that the output of the command line interaction did change a lot over tim=
es
> and using applications had issues. I've experienced a few of those over t=
he=20

Sure, but that is only for human consumption and not for scripts.

gpg introduced its --status-fd machine interface 19 years ago.


Shalom-Salam,

   Werner


=2D-=20
Die Gedanken sind frei.  Ausnahmen regelt ein Bundesgesetz.

--=ANZUS_CDC_Roswell_defense_information_warfare_bluebird_AMW_PET=Uzbek
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTX/8BjtAoilLlm20f/gK6dHew1jQUCWNOpzwAKCRD/gK6dHew1
jZ5BAQDyAYmPkgINUihDqR96tU2Xtng7FmTJD/XHbzfIVck7agEA3vJfR6EN38XS
cMIN9gmDY1YrCC810+SWQMWilPsKeAA=
=tnSd
-----END PGP SIGNATURE-----
--=ANZUS_CDC_Roswell_defense_information_warfare_bluebird_AMW_PET=Uzbek--

