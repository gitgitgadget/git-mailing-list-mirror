Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABAD81F424
	for <e@80x24.org>; Fri,  6 Apr 2018 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeDFKit (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 06:38:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:59775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeDFKis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 06:38:48 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LskfZ-1eOQFo3p4z-012Izw; Fri, 06
 Apr 2018 12:38:46 +0200
Date:   Fri, 6 Apr 2018 12:38:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Make running git under other debugger-like programs
 easy
In-Reply-To: <CABPp-BHhdxuV9a_4OfgaRu89Kx2039OLeS1vW-KdzpLxb-ZF3g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804061233330.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405174935.598-1-newren@gmail.com> <nycvar.QRO.7.76.6.1804052144310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CABPp-BHhdxuV9a_4OfgaRu89Kx2039OLeS1vW-KdzpLxb-ZF3g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TV9HcBKBPLcwNpH/oQcNg2X/uUMD1z9JWiuN4DjRcU7kVcSW6Vr
 UaMcsO+cx2WX7N2ymulyAU3EUqNTgvhH026s7p271/LJQWWh30dX8IdlFiC5jyFTbSeBm+T
 zCnY8W6MlLJnp940rpSXTipqLZtc+pZNREcW6FBe+uuBEIyxYHx35bSHfHthd/Ojx+E2KVt
 cZl7xSlrwVD7AFCA8lB/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7mdtI5zjsPY=:ZQlSuJX0TPedwDLXR7tx5L
 vdksHekWc8tDuXHZP8ZUrBgKpmRHXxT/jRES72pvU3muFJesdiG3YEbIGNQVQm1uMKU0B+P0v
 f3/mbLHO1pSTXtpH1mdbYgxtSyY8azsRzwwedCpPCJUBl+4mHEr5OpU38XMwnd8r6PgoO/Jyw
 7OwcvPcvvqjo7z1Q7NLDoejApraawR9U7BF3lk+8HkEXbkXUrQUr2ZYdR3J4jyEKdkHkTqzx/
 xic5iRLskzjAUI0Itd9CULXJ1I6C4ygUFlGxTdiR0nKP5x0ejbVD0hHb4EdxBGRLdC3Fu+/8b
 tlqRtYdP5VXFGh8YboEOAWp3RukzTJs5wGqgrEgaWrwlPK815oiasXwpPWk1H24SnP60zQcJf
 xRAxemczzb8dpt6QLPGO5lUWeChQ8sP+L54TAP16wg1UQtbpQYyq8jN/YPNz0TDp7R+wNlner
 xZmzfK5YFQE7ilPbA0m16j5CFuqXp2ZTeAIvldyK5ZKOkZH7fZvJh31F6BRt1qIkVNxeev6gz
 1i6yq4UeRmU2OvjG/6Ln4nNjCgz/Zc8/E1QrAVrn+qURiRtdiZT1L5lUPSDz4/e0SX5JM8wQJ
 E/cjjgvdE97hdvXRGvJ4lWg5ZAppJBcEe8MNr7wt5VovgDXVC4xMFU9yDFY4jNnOVJ4w0i8gZ
 TbpixB5Ysk7yMO/Pd80D/CygjYR+lmNmkKl4TT0wZ9O5jGna+cPgje1Cr/fmvMw61dgu83+NG
 zFMOWQRAfeWA9r5K/afeH42VHvQoEWJwxuoLYY8TYK28D+y92zkHobGujtXPYktdvejaMoXbA
 yWUr9S4VVw56hjVYsViG6NorvDv97lMSaUwTvOYPLBIAdyHH9DvNHAFFQeWN5vHIBFoeGP6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 5 Apr 2018, Elijah Newren wrote:

> On Thu, Apr 5, 2018 at 12:57 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > I wonder whether a better approach would be to add an optional argument to
> > that `debug` function (which is intended to have `git` as first argument,
> > anyway, or at least a command/function that does not start with a dash):
> >
> > debug_aux () {
> >         shift
> >         "$@" <&6 >&5 2>&7
> > }
> >
> > debug () {
> >         case "$1" in
> >         -d)
> >                 shift &&
> >                 GIT_TEST_GDB="$1" debug_aux "$@"
> >                 ;;
> >         --debugger=*)
> >                 GIT_TEST_GDB="${1#*=}" debug_aux "$@"
> >                 ;;
> >         *)
> >                 GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
> >                 ;;
> >         esac
> > }
> >
> > ... and then in wrap-for-bin.sh, we would replace the last lines
> >
> > if test -n "$GIT_TEST_GDB"
> > then
> >         unset GIT_TEST_GDB
> >         exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> > else
> >         exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> > fi
> >
> > by
> >
> > case "$GIT_TEST_GDB" in
> > '')
> >         exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> >         ;;
> > 1)
> >         unset GIT_TEST_GDB
> >         exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> >         ;;
> > *)
> >         GIT_TEST_GDB_$$="$GIT_TEST_GDB"
> >         unset GIT_TEST_GDB
> >         exec $GIT_TEST_GDB_$$ "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> >         ;;
> > esac
> >
> > or some such.
> 
> That all looks great to me.  But at this point, it seems like it's a
> full rewrite and your patch to submit (which I'd be happy to endorse
> in lieu of my own)...

:-)

> or do you want me to submit with you as author and me as committer?

That would be my preference. I have not even tested what I wrote above...

> Also, a side question: if we go this route, do we want to rename
> GIT_TEST_GDB to reflect its expanded usage?

Sure. Probably GIT_TEST_DEBUGGER? Or GIT_TEST_DBG? Or GIT_TEST_DEBUG?

> > Then your magic "GIT_WRAPPER" invocation would become a bit more explicit:
> >
> >     debug --debugger=nemiver git $ARGS
> >     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
> 
> No, for most (60-80%?) of my invocations, I wouldn't be able to use
> the debug function; only a minority of my uses are from within the
> testsuite.  The rest are from the command line (I have
> git/bin-wrappers/ in my $PATH),

Oy vey. bin-wrappers in your PATH? That's even worse than what I did in
the first two years of developing Git: I always ran `git` in-place.
However, I was bitten by a couple of bugs introduced while developing that
made it hard to recover (if I don't have a functional Git, I cannot use it
to go back to a working version, can I?). How do *you* deal with these
things?

> so the above suggestions would mean that my invocation would become:
> 
> GIT_TEST_GDB="nemiver" git $ARGS
> GIT_TEST_GDB="valgrind --tool-memcheck --track-origins=yes" git $ARGS

Right.

> > (In any case, "GIT_WRAPPER" is probably a name in want of being renamed.)
> 
> Well, with your suggestion, it'd just be whatever that environment
> variable is named.  I'm perfectly happy with something other than
> GIT_WRAPPER (or GIT_TEST_GDB).  I'm not so good at coming up with such
> myself, but maybe something like GIT_DEBUGGER or GIT_DEBUG_WITH?

I like both. Pick whatever you like, as long as it starts with `GIT_` and
is descriptive enough. Even `GIT_LAUNCH_THROUGH` would work, but
`GIT_DEBUGGER` seems to be the shortest that still makes sense.

Ciao,
Dscho
