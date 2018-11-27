Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D891F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 12:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbeK0Xxj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 18:53:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:40395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeK0Xxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 18:53:39 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lk7fW-1fquAf3siY-00c6Ny; Tue, 27
 Nov 2018 13:55:44 +0100
Date:   Tue, 27 Nov 2018 13:55:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Steven Penny <svnpenn@gmail.com>, tboegi@web.de,
        git@vger.kernel.org
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo'
 is working (again)
In-Reply-To: <xmqqlg5ft7pe.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811271352560.41@tvgsbejvaqbjf.bet>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>        <20181126173252.1558-1-tboegi@web.de>        <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com>        <CAAXzdLX4jU7+i1W1A_Q1LpPFa1D4FYVPW5rcMnqr_tDHEJn+tw@mail.gmail.com>
 <xmqqlg5ft7pe.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HQZzWMMbaA6Ihp6kr+Rz5Y043C+FxUSeHxvk4VtFZIJr9hO2E3b
 OGq4+xiHl1a5K3pFMOT4U8PtohUz2bUc36vEKut+FUBk/u7Bosk/aIBRx7ufgH0QuGaxUze
 5YsF5JqwabuqX0sBNnKUL8Qdyy1e8EwNroWrbPey1GEtMKuEiWHNbXGse5acvMcB505S3wO
 cu8Pb5zqTPnaQXTPEkQtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9x7sut4neO0=:w56cjh+wjDSzvCND8rLnGL
 eoaN/ojQgtIFGJmpAv/biYYBq2e8t1/u+z9PpAcZlzclEN2yZZerYSQ13uI3oZXRauF17KJu8
 kdTL9bY4o4S4XCv3VvFKOAUYMnsV8MRWz6UAZLAvkpPDp7ScjKg6ITFdb51YonMk/JAAAglHL
 EslDuw7ZIU6g9uU0PerJvP45FZbcCLojNMNn8UOL3L3dMYhSjvgwkEPX1756TXUVKSe3HCh9T
 qJE/Q2Ss1NPfEDpImirSoixiIn9sxCOF6SKJQMhloJ38PbGRygrjJy4pSQfwjSlnc2pWD/feU
 AhzKJALnyzsE7FcsJjtZ/fmpgIagchtIRaAfy/r6W3z688Y//NZUrILlzpJbEmhUc4od83na3
 2PfU70eonenHbk94TDAzbgvedp3aOHgCzCnf9JRztdAR8fxphWcYAtk8XG9178hGPtyKbouxn
 /Ar/sROq9oQK6KwmIKh3gTiZysB660lxyyLubeSiq+sBu3L0iGPurbj4pddFIVn0gmwXnKIVC
 ID6lXct93yjhH/4bR321jTFb1exVFQI1wpO8IPVMMp8RLXIkKNStYGDDHrfLthbYfbp7/CSUJ
 4kCGhLwl240P6duFAt9ZkTFUAUB6booysVkypmQWgEYSfRpE8K8hoijmPNRfl8kNf1lyMgWh7
 CiXhs6LfXisTs5bN2V5LeegJJKxiqoxFypp+NjtkjRxD8plHfkTHD8Ew/2+TbcoiPqLX13Bws
 QcCSvZU3J/5A8hJhSKEABmgNGeUnXMYNuMsl7tlHMLNgg/CW9ZgXTg6O7fsGVNYV9TCLqZKOg
 1sWSAQ7fI/1fJdCcwuZpL55vmar4vNwjV6hujZexXnFAF4DcKdgXyqBSvpudMwsLbo8gfDmef
 IMzhA5FUbw6pbIF5w5c2D/nqfaq/kC+VurzAzDlvVYj0htVNe0nhhpoVkigPl6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Nov 2018, Junio C Hamano wrote:

> Steven Penny <svnpenn@gmail.com> writes:
> 
> > If you strip the drive, you can still navigate within the same drive:
> >
> >     $ cd 'C:\Users'
> >     $ pwd
> >     /cygdrive/c/Users
> >
> >     $ cd '\Windows'
> >     $ pwd
> >     /cygdrive/c/Windows
> >
> > but you can no longer traverse drives:
> >
> >     $ cd '\Testing'
> >     sh: cd: \Testing: No such file or directory
> 
> Sorry, but I fail to see the point the last example wants to make.

I agree. For me, the real test is this:

me@work ~
$ cd /cygdrive

me@work /cygdrive
$ ls
c  d

So `/cygdrive` *is* a valid directory in Cygwin.

> > I would say these could be merged into a "win.h" or similar. Cygwin typically
> > leans toward the "/unix/style" while MINGW has been more tolerant of
> > "C:\Windows\Style" and "C:/Mixed/Style" paths, i dont see that changing.
> 
> I'd defer to Windows folks to decide if a unified win.h is a good
> idea.

We already have such a thing, but it is not just `win.h`, it is
`compat/win32/`. I would think that the best idea would be to move the
MINGW variants to `compat/win32/path-utils.c` and declare them in
`compat/win32/path-utils.h`, renaming them from `mingw_*()` to
`win32_*()`.

Ciao,
Dscho
