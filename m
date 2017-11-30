Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACED120A40
	for <e@80x24.org>; Thu, 30 Nov 2017 01:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbdK3BoY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 20:44:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:54264 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753305AbdK3BoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 20:44:23 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mg3Vt-1eW07F3RjR-00NQpn; Thu, 30
 Nov 2017 02:44:20 +0100
Date:   Thu, 30 Nov 2017 02:44:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.15.1
In-Reply-To: <af169d17-708e-5ec0-53ee-b85df76e67c2@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711300238520.6482@virtualbox>
References: <20171129135723.11664-1-johannes.schindelin@gmx.de> <af169d17-708e-5ec0-53ee-b85df76e67c2@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tXDP/g3i8PWgIKePOtqhGSCOe+ZtXooIT4BMQfgaiibtEcebLoR
 BzNaD6Q7kCT/Gq4CLV+O9T/E0ojmCBs65pa2OD0mFJK4YXWMOeZ8WHnuuyOU06XMC85bTBy
 KR3plCTRl76S0cD1pa2F2PL6DyS4NguUwW7gLdmcnVk+YdDEIyIcytqQk+UEgfWvEmEaJ8s
 g14HHcr3t3oqJSlN9Q0UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G6li2gRjbqE=:hwLKgCOB57pkUu4s9jJuUd
 4RVDUI8byFSjK3uyZF54aK8b9vS6UVu6Uzp2Q6b00s2s2m5veSTh+w5WQE0unQA+T5dRPcjzQ
 EROXq6fvSlbAvmU8mMQREni0V/Ji2vv5bKQvA1riztSbi8ND60RONof4RrnWc4zfcFXVMAVx5
 f0kAQm8bgzRIc9ieFufa7r9GguCDGYY2548ibR5co8g8OaM5Xp/2/U+GD8wgO5TdE4Hgif8kA
 wWMKj5/ZHGfifSpvM6bBGeYpaUaHXoXBuI7Vt9au7zcucTAFyrEtLg8KYELmfkaTU7fx/y/ee
 yTSFVYW9QQrbsZwFMKPvJY7KmObJ1Umn+0LgKslQ3kRm7Uk1daPr6NuCBQlVEjd3eOLPkrptV
 ROOM0zx880BFz+wsQEVKTPgPNI8PjEc6x0lBVMqp8bK3WX8GdL6tVQQyasGnrehPywCJWQsJl
 +MZBzF7xOFzYnjg0wJ/ZzeF1XizZj33TlGnqo33y3fyyobGxVXjUnzX4F8C1OSRcJFWLqY+N7
 tT6mAKtnvBKAtDDwz3lel1IbvpD1EHJZwA4qhc+hiBBFbWUwkxsKR33zb05wgl7HkqO0K37fL
 0rZi6aQY3aO4ZB0+iT1H7hODRwqaiN2yd2steucUM2G6xx4EVuzMNS+4AHAyhVTqjlRJGUWhT
 tZYpQbN2Dz0HVVGnSKRWcrMuHB9Bjs7eqNQ9vUv4O12EinHmC2Hr5DLxgWD6ODSUTZ1Nfq7a0
 S6LYDgJzR4Z0jAvvYsV2/ARt9rBINOqT8Vwu9mU1auL1v/Sn4uKjLVbeDvpmGLUxxJ96EtdTQ
 jVYzURjK1x9MflRzJhMOTWa2ZVhOIrP7xc6+H+P4JccVe0vv44=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Thu, 30 Nov 2017, Igor Djordjevic wrote:

> On 29/11/2017 14:57, Johannes Schindelin wrote:
> > 
> >   * It is now possible to configure nano or Notepad++ as Git's
> >     default editor instead of vim.
> 
> This seems as a really nice option, as it could\should greatly help 
> Windows people in lowering friction in first encounter with Git (for 
> Windows).
> 
> Being pretty unfamiliar with Linux and its tools at the time, I 
> remember the initial frustration in trying to do what otherwise felt 
> as a no-brain, simple and trivial task - write the damn commit 
> message after `git commit`, lol. Even had to kill the bash window a 
> few times, not knowing what to do, where it was clear it was 
> expecting something from me :$
> 
> I later learned about vim, like getting started with Git wasn`t hard 
> enough... :) As soon as I found it being a possibility, I`ve set 
> Notepad++ as my default editor.

Thanks for this entertaining personal account!

And yes, you guessed it, I wanted this option for a long time, but never
got around to it (always hoping that somebody would beat me to it...). BTW
this installer page is probably far from done, there is a lot of room for
improvement, e.g. this up-for-grabs ticket:

	https://github.com/git-for-windows/git/issues/1356

(hint, hint ;-))

> That said, what is the Notepad++ as default editor option doing, just 
> setting:
> 
> [core]
> 	editor = 'F:/Install/Notepad++/notepad++.exe' -multiInst -notabbar -nosession
> 
> ... inside users` .gitconfig (`git config --global`)?

As you found out, it is set in the system config. There are two reasons
for that:

- the installer runs as administrator, so it cannot know for which user you
  want to configure Notepad++

- in case the user does not like the setting (as in your case), they can
  still override it in their $HOME forever.

Ciao,
Johannes
