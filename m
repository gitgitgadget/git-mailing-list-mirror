Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331C520A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 11:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeLNLL1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 06:11:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:45469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbeLNLL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 06:11:27 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCxfb-1gfljO3HrX-009hae; Fri, 14
 Dec 2018 12:11:13 +0100
Date:   Fri, 14 Dec 2018 12:10:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] .gitattributes: ensure t/oid-info/* has eol=lf
In-Reply-To: <20181214005101.GT890086@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1812141204040.43@tvgsbejvaqbjf.bet>
References: <pull.98.git.gitgitgadget@gmail.com> <pull.98.v2.git.gitgitgadget@gmail.com> <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com> <20181214005101.GT890086@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fTeI4am8zO2GaSHfdGzFTOvnVVCuge1CV3DS/raHtRKj632XI8K
 8r6+dpnVKWR2V/fYe2ZJclTtf2hA4blN90sRPJX5piL5XcjmxDZK+tQ5+kVVY5Q59dFmJHX
 +Zn2EHTkGMXLmeUrPnHnhNxB9Z7yunIe6IdQJgSxKTTQCRUvlB4PWHFEAYLSf8rnnCJhVLJ
 1uaI9QVmU8RZIa8lN2ywg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dq5/hURH5Gw=:oECAzik7pmipWUJBpneLHJ
 9EBVuZxvRYuU22kvpwkctrgA3gWik/5hrnCWLwi7U1aMG3D9+7d43cURad+UOBLUO37Q22/sZ
 6DmbTd6iFZxMwZFIjhHJddQ1XOrD8EAMNI/Yw3r5OBB5xkTGAdg2Fgy8ZstIziZ/HVKEH+a2S
 8JxVa0yRd2PRWu1aU1DV3dLlwj39GRlE1M8bPXSh19AL9zNjfUGsm5OqFEZA6mU/q7p7nKrai
 NHGguHo0+LsQc1Anvkw7s38vWg0M2LJiYb0HlCMQ7I2rhDRp6u2VFyEBVBRPuUDbvNmt6zDBY
 eS42OJgwo5epTZlT3xU+jvKsZgFiUOKql7QjmqXHiNJWJ18J8Nu9GI1G7xGcMmqCIDPWzjvUo
 nmlrHkZ5htVlQmOj1yUu6VAGtzws4CdLLlUHOds0/JH8EkbCUtb3stgqtDwWrIYnipelYhAgm
 ceXj6OpTuWglFgn3UZwxWB1NR9pb6azcSfh6E9EHxTza+XJy8+MMAus7wxcfsgNjO1Hq6Wcfi
 GYv7zt+kEGU6AMFH9DZG3wFm8UHgz9HDZNSCB3qMxMJ/YRScWutunDDw9M511LF+hAPe2bDIz
 39mKrDeh3nNmBxv9OGavU+PEe8Lr0qHqRo9Oesn9y72WJ5HHhhw/AB8lLguq4TEvK4iNov5Q7
 FngvAXYjFGVwS8AuqO0Imw3lwMKNA9kC85PbFjNLhm+P47V+ADyuMEJy6+AFbvv3plj+eGmsK
 K2MgGc6ZL/6mUCxW/NbcqgeJGBci7/73Rmj0hfZ0Bj7u2xs3dooz+Xnim6KbQDjn28Lwk2D9H
 LHkmI/UIwLs0Q4mnBs71UQg4gRoLiweQcQjHrz8x/uZ2T2tYfnlnlzz5ed5i6138ZSj3o04z8
 bql3Ld5f3WRutUr4b9QM7Eb2Z5qtY6m3rKCVBOFITjXU4d6vqAdNoRfise7G4VzvifLwQAlDP
 5UDliZM9vlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Fri, 14 Dec 2018, brian m. carlson wrote:

> On Wed, Dec 12, 2018 at 10:14:53AM -0800, Derrick Stolee via GitGitGadget wrote:
> > 
> > diff --git a/.gitattributes b/.gitattributes
> > index acf853e029..3738cea7eb 100644
> > --- a/.gitattributes
> > +++ b/.gitattributes
> > @@ -13,3 +13,4 @@
> >  /Documentation/gitk.txt conflict-marker-size=32
> >  /Documentation/user-manual.txt conflict-marker-size=32
> >  /t/t????-*.sh conflict-marker-size=32
> > +/t/oid-info/* eol=lf
> 
> Yeah, this seems like a sensible thing to do. I assumed the shell on
> Windows would read data as text files, not as binary files.

This is a tricky thing right there. The Bash we use is  borrowed from the
MSYS2 project, which tries to stay as close to Unix/Linux as possible,
i.e. it does *not* treat Carriage Return as part of the line ending.
Changing that default would break tons of things, I would expect.

> It's kinda hard for me as a non-Windows user to predict what will need
> CRLF endings and what will need LF endings with Git on Windows.

Right. It is my hope that I get the Azure Pipelines support going soon, so
that Pull Requests on GitHub are tested on Windows, too. Hopefully that
would help.

Typically, I monitor the Windows builds of `pu` closely. But in this case,
it did not catch because the current Azure Pipeline that runs these tests
(triggered via Travis) specifically forces `core.autocrlf` to `false`, as
that definition pre-dates the work I've done to make Git's source code
CR/LF safe.

I do have a build definition to test with `core.autocrlf = true`, but that
only runs on Git for Windows' `master`, and once git.git has its own Azure
Pipeline, I plan on adding another phase to test that directly.

Ciao,
Dscho
