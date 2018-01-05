Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6AA1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 16:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeAEQlk (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 11:41:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:49425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbeAEQlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 11:41:39 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MGFz9-1eilBa21cF-00FG0I; Fri, 05 Jan 2018 17:41:33 +0100
Date:   Fri, 5 Jan 2018 17:41:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 7/7] wildmatch test: create & test files on disk in
 addition to in-memory
In-Reply-To: <20180104192657.28019-8-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801051622010.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <20180104192657.28019-1-avarab@gmail.com> <20180104192657.28019-8-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1639289009-1515170493=:1337"
X-Provags-ID: V03:K0:Ndk7bKuJJS+iMv5E1IR7IqfhpKvB9GiL07LrFqo3AaxxUMLBvrP
 VWEne4BNOxsFaNH63tWRBy3S4l3uMbvHDVc21SoL9+05i9WITiUBNzKQa/gJ/lIjigUM2DC
 OzrDuojUBcklSuKHBWuKseJs27gmFDfeAMmR/mRbnBNjdmNIXrFYbWOZy1+A5NBtY7pYao4
 lB6zXZHI2JZmaiuvnxBEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BvwKfcvZ5FM=:1vxiEg5/LdYDTDr/C9sCMp
 BcXEYsvxavFIuYYcJ8Zm9soKU51EO5o5kw0sAw/xwAhVdmH6XHYFMjkziwSRL3YHPdrALy4f8
 X0/6vtBgyitVnqFiYO/DrJwF7czeCicSM0STnYH5xtB6y6OZ+qosyk/PeYeqFwSENOLlMjABt
 MyU40qLoum5zpLaxElxQtQI4Tmvf4YPQwQXwQhh7yT4lPKU7GVLNaoVC4b9upd4V34B9MkZgd
 EgkAjVDTSIZ/3N07Aszth7bIS3ryR+h/gXwqn3dGnqNN+9bVlomolOEiU0RL1AXIvMEFzK+Uh
 MHc/vVvdq6QeBpUot4m8v2pR/4CFOBUcqiQjmU2elxreMqQCHcWucOKJpc64T3A7uJcfHxxnN
 68EWVC6VbxRWwwgAnAnzezsb8mZ6wy/v7BadDIAEZIfQs/Tw0gBneSUuEFlWC9k0Io1hkjXTP
 WmfrUDdVAkE5D/+cU2Yskno5rIr5eP8lbbNtjV5ObDl/oORiktM/ku3MAMUZdphQi3iqikA6b
 DbYMUXoXeqg0uxxkbGki/sVHiZ0Mh6U9O5lXPyW/Fvmq6a9TQYRCnTFCIrA7mkIkySbWrCNFM
 deLzNvRTGuij2Uo8CVRMWpyNk1QnuD1DVV0pW2hs212MjhxAoGva07PP0uoaFPmvvzGrAAx3v
 vqHiR3mrZxdjOOps/Ib6hwj/qRO9XMsd4rmniuIxmA40xBN1P2upYHjraywp6cHKWN+/B9dvy
 qU2H8WdCTb0//YMZ4LMioL6BVQr0JP55foFN/TWn9Vz1OnD3u0VJi9jlX5ks5yJOgKfAO9L6b
 bW2Y9MHwqmwSFdNoRcckkwpcNM1RSW0wzR09UDgIo6D9hw8gkMEDiWTb+zoQuVVx/helD9C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1639289009-1515170493=:1337
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

I spent the last 3.5 hours chasing down a bug in your patch series that
seems to be Windows specific, so please forgive me if the following might
leak a bit of my frustration into the open...

On Thu, 4 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>  t/t3070-wildmatch.sh | 301 +++++++++++++++++++++++++++++++++++++++++++++=
++++--

Wow, this file is ugly. Sorry, that was an outburst, you did not deserve
that, but I have to say that it is *really* hard to wrap your head around
lines like this:

=09wildtest 1 1 1 1 'foo*' 'foo\*'

What are those 1s supposed to mean? Granted, for you, the author of this
line, it is easy.

The point, though, of regression tests is not only to catch regressions
but also to make it easy to fix them. Not only for the test script's
author, but for others, too (and your script is not even the best example
we have for a script that needs hours to study before one can even hope to
begin to see what is going wrong... I am looking at you, t0027, yes, you.
You know why).

So then I go and see that the `wildtest` function has magic to handle both
6 and 10 parameters. And those parameters get assigned to variable names
as intuitive as `match_f_w_pathmatchi`...

The next thing about the test script is this: calling it with -x is pretty
much useless, because *so much* is happening outside of
test_expect_success clauses (and is therefore *not* traced).

Of course I can debug this, but can't this be easier? And this is not even
a regression after a couple of years, this is fresh from the start...

So here is the first bummer about your rather extensive test (which I
think tests the same behavior over and over and over again, just with
slight variations which however do not matter all that much... for
example, it should be enough to verify *without* filenames that the
globbing of wildmatch() works, and then a single test *with* a filename
should suffice to verify that the connection between globbing and files
works): it requires filenames that are illegal on Windows. Stars, question
marks: forbidden.

Worse, since we have to use Unix shell scripts to perform our
"platform-independent" tests, we have to rely on a Unix shell interpreter,
and Git for Windows uses MSYS2's Bash, which means that we inherit most of
Cygwin's behavior.

Now, Cygwin wants to be cute and allow those illegal filenames because (as
is demonstrated here quite nicely) Unix programmers don't give one bit of
a flying fish about portable filesystem requirements.

So Cygwin maps those illegal characters into a private Unicode page. Which
means that Cygwin can read them alright, but no non-Cygwin program
recognizes the stars and question marks and tabs and newlines. Including
Git.

In short: the Unix shell script t3070 manages to write what it thinks is a
file called 'foo*', but Git only sees 'foo<some-undisplayable-character>'.

I tried to address this problem with this patch:

-- snip --
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index f606f91acbb..51dcb675e7b 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -4,6 +4,14 @@ test_description=3D'wildmatch tests'
=20
 . ./test-lib.sh
=20
+if test_have_prereq !MINGW && touch -- 'a*b' 2>/dev/null
+then
+=09test_set_prereq FILENAMESWITHSTARS
+else
+=09say 'Your filesystem does not allow stars in filenames.'
+fi
+rm -f 'a*b'
+
 create_test_file() {
 =09file=3D$1
=20
@@ -28,6 +36,17 @@ create_test_file() {
 =09*/)
 =09=09return 1
 =09=09;;
+=09# On Windows, stars are not allowed in filenames. Git for Windows'
+=09# Bash, however, is based on Cygwin which plays funny names with a
+=09# private Unicode page to emulate stars in filenames. Meaning that
+=09# the shell script will "succeed" to write the file, but Git will
+=09# not see it. Nor any other, regular Windows process.
+=09*\**|*\[*)
+=09=09if ! test_have_prereq FILENAMESWITHSTARS
+=09=09then
+=09=09=09return 1
+=09=09fi
+=09=09;;
 =09# On Windows, \ in paths is silently converted to /, which
 =09# would result in the "touch" below working, but the test
 =09# itself failing. See 6fd1106aa4 ("t3700: Skip a test with
-- snap --

This gets us further. But not by much:

fatal: Invalid path '\[ab]': No such file or directory

You see, any path starting with a backslash *is* an absolute path on
Windows. It is relative to the current drive.

This affects *quite* a few of the test cases you added.

And even if I just comment all of those out, I run into the next problem
where you try to create a file whose name consists of a single space,
which is also illegal on Windows.

These woes demonstrate one problem with the approach of overzealously
testing *everything*. You are kind of performing an integration test of
the wildmatch() functionality, the integration into ls-files, *and* of a
filesystem that behaves like the filesystems you are used to.

All you *should* want to test, though, is the wildmatch() functionality.
And *maybe* one or two tests verifying that this wildmatch() functionality
is actually hooked up into ls-files correctly.

You do not need to test that 'a*' matches the strings 'a', 'ab', 'abc',
'abcd', 'abcde', 'abcdef', etc. *and* filenames identical to those
strings. If we already verified (lightly) that wildmatch() *works*, then
we only have to make sure that ls-files uses wildmatch() correctly.
Everything else is useless expense of innocent electrons and neurons of
other developers.

Another problem with this approach (*extensive* testing of essentially the
same stuff over and over again) is what I mentioned earlier: these
tests are really hard to read, and it is even harder to debug test
failures.

And lastly, this approach of overzealously testing *everything* simply
takes *a lot of time* and also electricity. As a developer of patches who
runs the entire test suite before submitting every iteration of every
patch series, this affects me. Others, too, I guess, and they might just
skip the test suite as a consequence because it takes too long. Don't
sneer, you know that this is happening.

Needless to say, I am not enthused.

I would much rather have a lean and mean test script that tested things
lightly, in more of a unit test fashion: test wildmatch. Just wildmatch.
Not ls-files, no filesystem, no nothing. There is already
t/helper/test-wildmatch, for crying out loud. Just feed it test data
together with expected outcomes, will make things much easier to debug,
faster to execute, and be a lot easier to read and modify/fix.

Whatever you decide, in the current form this cannot go to master, as it
fails royally on Windows.

Ciao,
Dscho
--8323328-1639289009-1515170493=:1337--
