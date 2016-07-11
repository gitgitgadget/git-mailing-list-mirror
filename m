Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2771E1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933888AbcGKQ2R (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 12:28:17 -0400
Received: from mout.web.de ([212.227.15.14]:53813 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933732AbcGKQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 12:28:16 -0400
Received: from [192.168.178.24] ([84.61.32.248]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MMn8x-1bTX9B3TFX-008ZUe; Mon, 11 Jul 2016 18:28:10
 +0200
Subject: Re: Commits are no longer gpg-signed in 2.9.0 when "commit.gpgsign"
 is enabled
To:	Santiago Torres <santiago@nyu.edu>
References: <57838306.5090505@web.de>
 <20160711144420.nsibnudjxvgdz7cl@LykOS.localdomain>
Cc:	git@vger.kernel.org
From:	Nils Fenner <nilsfenner@web.de>
Message-ID: <5783C90D.1010909@web.de>
Date:	Mon, 11 Jul 2016 18:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160711144420.nsibnudjxvgdz7cl@LykOS.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gKH416SGp021s8l4WI027SuGr6GmTBqpg"
X-Provags-ID: V03:K0:XzMYuicAxh7umil1TDcGGlUkndKI67h8nI/ybjrSUoIuy20afm5
 BiB2KmN3iK99hA2ORAyKWGhDARkf34jjOJMWprZsbO/65LGl1a65RFqfSQCTXuyZO2kyfLl
 HJ4tqtrz91RA7I0xU9CdfvGFu+H8RuiOxBmRJ/JcCR4wBvwtmD8snyI0CKu00W4NOlr6upE
 ugCetoI5ZpVJFvN72GBqg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uAA/qwuclZQ=:LWdrzlNNj8hQ4sJJm8mWVG
 RMP/cgs9bx8xIOlu9lIeKouXbPzkN3qzUqjEmFkjrHGUII6I4Df6f+AQNqvx0YTW1WhSPUFms
 3u9gMjBOa9XL0F3j0zL2p7SwNVEcb5QWjm9hkoWVBlIMQg6ClxDJh6ccZYUYKsGWlKwo7mmI+
 e+815GnvKdzgPtVy4WW5Cp5n+AJOXu7RbzKnHJLM88qaA2N51l1TYf3toWw9LzDgpNeNQfVJL
 Pilu3ylDOYPHhNOuze9j0UPe6BM+ZpXffqyM9ob0nnOHqmxUhiSk5xzgGmE9QREew60+YsVU/
 OP68QYil5W4GDhz2LAwuMInXh1hopep7oduxzl8OcKEqvSEoGj8mX/tTjMrZhXdybQrbYoBLq
 vVz3Mdzt3KzPMDMcDDwGVEdWqWvrdMnGUHJRe5JmCB/IW4o1rywgb/6kumxDpQvv8j7n2anBd
 4RREVhqiJ3apPvlnwg6GWEEJR01rkCIExFmEFvHH1pEXZs65tufKfdqVndCj2442OBDwhTFsX
 uaE3eoG30mblSwdOITXHluJoS6fKgnbVAOAIrXsUh0KW3gbp9pwLa41SbyrwzyMtINqvhltpb
 0Las8lwQIUwZuPL1HddR/NnYuf5lqijg6H4t2cUXYwxStbSB6+RtI+iJj/Wc2RfQi0qIu7Wrl
 w4YGyBiAAg5TmqHAXuDVhhJUbcgrON/9reUaKLrmy0HHnfmOO5c4bn8bIq2/sin7gu3/JuVjE
 7GTvZPXIftUuW0Up0c9Zfiv1UuN36ei7o6xCNCGDPRCK1+3WCK86FzEPk3I=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gKH416SGp021s8l4WI027SuGr6GmTBqpg
Content-Type: multipart/mixed; boundary="x6a5KDjAUU1XJOrR6TTpcVn3laojA2miD"
From: Nils Fenner <nilsfenner@web.de>
To: Santiago Torres <santiago@nyu.edu>
Cc: git@vger.kernel.org
Message-ID: <5783C90D.1010909@web.de>
Subject: Re: Commits are no longer gpg-signed in 2.9.0 when "commit.gpgsign"
 is enabled
References: <57838306.5090505@web.de>
 <20160711144420.nsibnudjxvgdz7cl@LykOS.localdomain>
In-Reply-To: <20160711144420.nsibnudjxvgdz7cl@LykOS.localdomain>

--x6a5KDjAUU1XJOrR6TTpcVn3laojA2miD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Santiago,

repeated your test here and actually found something interesting. When
committing via 'git gui', commits are not being gpg-signed, while firing
a 'git commit' shows the passphrase dialog and signs the commit correctly=
=2E

Here's what I did:

git init gpg-signing-test && cd gpg-signing-test
git config --local commit.gpgSign true
echo 'Commits in this repo must all GPG signed!' > aFile.txt
git gui --> add change and commit

Result: No dialog shown and not pgp-signed!

Now I went further:
vi aFile.txt --> Prepend a "# " as another change
git commit

Here the passphrase dialog showed up and the commit got correctly signed!=


Side-Note: I also set "user. signingkey" in "global" Git configuration.

My local repo's config:

[core]
    repositoryformatversion =3D 0
    filemode =3D true
    bare =3D false
    logallrefupdates =3D true
[commit]
    gpgSign =3D true
[gui]
    wmstate =3D normal
    geometry =3D 872x391+0+0 205 177

--=20

What you mean by wme? Is it the gpg-agent's config or something?

Hope that points in the right direction.

Cheers,
Nils

Am 11.07.2016 um 16:44 schrieb Santiago Torres:
> Hi Nils,
>
> I just checked and I have commits made in 2.9 with this option set and =
I
> don't seem to have your issue. Here's what I did:
>
>     santiago at ~/test-signing =E2=9C=94 git init
>     Initialized empty Git repository in /home/santiago/test-signing/.gi=
t/
>     santiago at ~/test-signing =E2=9C=94 hub create
>     Updating origin
>     Enter passphrase for key '/home/santiago/.ssh/id_rsa':=20
>     created repository: SantiagoTorres/test-signing
>     santiago at ~/test-signing =E2=9C=94 touch testfile
>     santiago at ~/test-signing =E2=9C=94 git add testfile=20
>     santiago at ~/test-signing =E2=9C=94 git commit
>     i[master (root-commit) 6de1ad2] TEST: tests git autocommit setting
>      1 file changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 testfile
>     santiago at ~/test-signing =E2=9C=94 git log --show-signature
>     commit 6de1ad20237f042433f8b94a3bf8c7cc41711d90 (HEAD -> refs/heads=
/master)
>     gpg: Signature made Mon 11 Jul 2016 10:40:41 AM EDT using RSA key I=
D 468F122CE8162295
>     gpg: Good signature from "Santiago Torres <torresariass@gmail.com>"=
 [ultimate]
>     gpg:                 aka "Santiago Torres-Arias <santiago@nyu.edu>"=
 [ultimate]
>     Author: Santiago Torres <torresariass@gmail.com>
>     Date:   Mon Jul 11 10:40:32 2016 -0400
>
>         TEST: tests git autocommit setting
>     santiago at ~/test-signing =E2=9C=94 git push origin master
>     Enter passphrase for key '/home/santiago/.ssh/id_rsa':=20
>     Counting objects: 3, done.
>     Writing objects: 100% (3/3), 879 bytes | 0 bytes/s, done.
>     Total 3 (delta 0), reused 0 (delta 0)
>     To git@github.com:SantiagoTorres/test-signing.git
>      * [new branch]      master -> master
>     santiago at ~/test-signing =E2=9C=94 git --version
>     git version 2.9.0
>     santiago at ~/test-signing =E2=9C=94=20
>
> You can check the github repository=20
>
> Do you have a mwe/.gitconfig so I can take a look at it?=20
>
> I wonder if this issue is similar to what happened in mutt, where gpg
> doesn't show the password prompt using gpg-agent and it silently failed=
=2E
>
> Thanks,
> -Santiago.
>
> On Mon, Jul 11, 2016 at 01:29:10PM +0200, Nils Fenner wrote:
>> Hey Git community,
>>
>> since Version 2.9.0, the configuration option "commit.gpgsign" doesn't=
 work
>> as users would expect. By committing via 'git gui' (or usual 'git comm=
it'
>> without further option), commits are not being auto-signed any longer,=
 when
>> "commit.gpgSign" configuration option is set. I also couldn't find a f=
lag to
>> "workaround" that situation in the GUI. To my understanding, I now hav=
e to
>> pass the '-S' option to 'git commit' every time and GUI becomes "impra=
ctical
>> to use". Surprisingly, nobody seems having noticed this behavioural ch=
ange
>> since the release of 2.9.
>>
>> FYI: In the release log, there's a note stating, that this has been al=
tered
>> in the context of 'git commit-tree'. Maybe this interferes with "norma=
l"
>> behaviour.
>>
>> Would be happy hearing from you soon. Thanks!
>>
>> Cheers,
>> Nils
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--x6a5KDjAUU1XJOrR6TTpcVn3laojA2miD--

--gKH416SGp021s8l4WI027SuGr6GmTBqpg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXg8kTAAoJEJWRoWP/m+BMOSIH/ix0PLuiBztQw6yJ2pvRhuAD
XYzjz321AI5XEdbK9InX/wp4qh8oIUXVSzwu+30p+k/44/nfApiWc7gRdXIqJ5PM
ubcHboxCqxJ3cjNNA/iBzxKMWhhwHz0mIySGzHkWSGRr2CBjV8cdunERsl2Yhwzc
Hx4mr/IjtzgioHo3tFVyDJqjcO92hmIQFrduNyTVm4lqXZES0Dgcjl6y0Fd+Njff
+QRHKPEY0Izm3kbhYxVCy90eafFFD0TPigtIV5gbSatj9FbyHiAcq4nE6/rf5Pgf
Mbmuinkhu5rZ8IRtyBjtacHXhllLr5xrfNMH5EsV/4sVj/2uiX2pbaZmPhrNNnU=
=VlHp
-----END PGP SIGNATURE-----

--gKH416SGp021s8l4WI027SuGr6GmTBqpg--
