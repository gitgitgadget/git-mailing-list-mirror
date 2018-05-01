Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99DE215F4
	for <e@80x24.org>; Tue,  1 May 2018 13:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbeEANrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 09:47:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:38115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754084AbeEANrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 09:47:07 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUpI8-1eqJNC281k-00YCP1; Tue, 01
 May 2018 15:47:02 +0200
Date:   Tue, 1 May 2018 15:46:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
In-Reply-To: <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805011439580.79@tvgsbejvaqbjf.bet>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com> <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1901552921-1525182424=:79"
X-Provags-ID: V03:K1:lwIlqgjKlBSyTB2JIeS3b5xYnpno4Q1QLfWb8N1+st+yqptHIM+
 /65p+sOKBiD97FIuUdeFYL0n0YODbCYz03aKXXFNNxa2hTDaXZAqtHcRg8d8hRrd4PrMoxr
 3EdKzTqn8NMb35vjZxT9xcRfb3W5R0ZDI2ZR82z2Tvt7k+fGJ23XYEyGyZsVnJXa7hXtKzz
 o8q+zxSN1RhgO7kb8d9Nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kk1hoXHtIOY=:QHF55O9cdseXDode+fC+ef
 LKj46yTKRj/XSz/POQX2WSW6Iq1CllT39qJnYuqohn6qRp+WTuV9HGGwQ6QqmUJYSO4eLhbn5
 ntFHB5o+ciz9tzrU5R7YMwWHr/WBrrKfKIK3ycn13ZvZX1Vvd1BWVChIgL5Josc54JlaIM6G6
 8rnPVpX2NM232myFOh1jPZ+UEEqr5/SMJKxXSQO4hD1GmjdNxWlF2k6tDB5jzio3JeznQKF6z
 8qboG2j6wTYI6X3Hgiui0RG5cTRZb/17BeZVEdzCoZGdpVNO3C+NTnouNRCH3ZgVzqAFP4KfX
 ZwtS7c6aehUSuo+BuxVIlUh6nw96/V779/cW/oKLZawso61G2It4VSc7208nyll032L3gJ5Ah
 x9yMtqvbIew3ZBVZ/iKQDcfjKZWOy8SYxS3FM8RvJRGKxoS1MzwH9AjCCiwSmGMo7X38pkH4B
 FS6NmXLi1rhtNmqrySQwdaI3UXKjeyniYdfPgHtCjxEzEjIhhdrDRzEYaARqeCBy0MgYs2X1M
 Ck2ZIh3OBYtFxdUeF6dxuobYd45jGGM6UHpZHzSC8Be1199kYCgXNa/Mx0oB4HOBIX1JLHA8n
 yLhHHPVfOfECdajjLSKnkMFg1zRIUQe+BOXojx3+XDmXuu8SKqhbDxbQFspIZggd4mfJQH3Fj
 hwJGiMLk7ogaJ/EchERr8LJRQOIARqpm55zpfXwzXIO0/hQNKzOQCbna0bI4fwh+eRZRMBDRl
 dL/0sG0cq1Zdew3yyNdnfKvoOu0mfBKYkFoWE5/yEjpjeizArkN7DOOtAjlotyA5tBgkqXGCS
 fBiQnDZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1901552921-1525182424=:79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 30 Apr 2018, SZEDER G=C3=A1bor wrote:

> On Mon, Apr 30, 2018 at 5:25 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
> > * js/rebase-i-clean-msg-after-fixup-continue (2018-04-30) 4 commits
> >   - rebase --skip: clean up commit message after a failed fixup/squash
> >   - sequencer: always commit without editing when asked for
> >   - rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
> >   - rebase -i: demonstrate bugs with fixup!/squash! commit messages
>=20
> >   "git rebase -i" sometimes left intermediate "# This is a
> >   combination of N commits" message meant for the human consumption
> >   inside an editor in the final result in certain corner cases, which
> >   has been fixed.
>=20
> >   Will merge to 'next'.
>=20
> This topic branches off from v2.16.3.  However, its last patch uses
> the sequencer's parse_head() function, which was only added in
> v2.17.0-rc0~110^2~6 (sequencer: try to commit without forking 'git
> commit', 2017-11-24), in topic 'pw/sequencer-in-process-commit',
> leading to compilation errors.

Great find.

As luck has it, I recently played with tbdiff and compared what Junio
applied vs what I have, and found only context line changes (and Junio's
extra Signed-off-by: lines).

So the problem you found is not a problem with *my* branch, of course, as
I did not fork off of v2.16.3 (which is a bit arbitrary, I must say: if
you want to fix these bugs for reals, you'd have to go all the way back to
where fixup!/squash!  support was introduced).

However, as a maintainer I am sympathetic to the goal of wanting to have
*one* branch that does not need to be backported.

The patch to make all of this work is most likely this:

-- snip --
sequencer: backport parse_head()

This function exists in v2.17.0, and will be used in the upcoming fixes
for bugs when running `git rebase --skip` after a fixup/squash failed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

--
diff --git a/sequencer.c b/sequencer.c
index a766796d1a7..f9c478a4d79 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -695,6 +695,29 @@ static int run_git_commit(const char *defmsg, struct r=
eplay_opts *opts,
 =09return run_command(&cmd);
 }
=20
+static int parse_head(struct commit **head)
+{
+=09struct commit *current_head;
+=09struct object_id oid;
+
+=09if (get_oid("HEAD", &oid)) {
+=09=09current_head =3D NULL;
+=09} else {
+=09=09current_head =3D lookup_commit_reference(&oid);
+=09=09if (!current_head)
+=09=09=09return error(_("could not parse HEAD"));
+=09=09if (oidcmp(&oid, &current_head->object.oid)) {
+=09=09=09warning(_("HEAD %s is not a commit!"),
+=09=09=09=09oid_to_hex(&oid));
+=09=09}
+=09=09if (parse_commit(current_head))
+=09=09=09return error(_("could not parse HEAD commit"));
+=09}
+=09*head =3D current_head;
+
+=09return 0;
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 =09const struct object_id *ptree_oid;
-- snap --

I also had to apply this to make things compile with DEVELOPER=3D1:

-- snip --
diff --git a/sequencer.c b/sequencer.c
index f9c478a4d79..44b1874f459 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2345,7 +2345,7 @@ static int commit_staged_changes(struct replay_opts *=
opts,
 =09=09=09=09 * We need to update the squash message to skip
 =09=09=09=09 * the latest commit message.
 =09=09=09=09 */
-=09=09=09=09struct commit *commit;
+=09=09=09=09struct commit *commit =3D NULL;
 =09=09=09=09const char *path =3D rebase_path_squash_msg();
=20
 =09=09=09=09if (parse_head(&commit) ||
-- snap --

This should most likely be squashed into "rebase --skip: clean up commit
message after a failed fixup/squash".

Junio, for your convenience, I pushed what I have here to the
`clean-msg-after-fixup-continue-backport-v2.16.3` branch on
https://github.com/dscho/git

For shiggles, I also looked how far back I could push this, and backported
to v2.15.1, v2.14.3, v2.13.6, v2.12.5

Things got painful only really with v2.12.5. Like, really painful. And in
the end not even worth it... I managed to backport the changes, sure, but
that code path is not even used ;-)

For your convenience, I pushed all of the backports, just in case you want
to use them. I did leave a couple of fixup! commits in place, to show a
*little* better what I did and where.

Ciao,
Dscho
--8323328-1901552921-1525182424=:79--
