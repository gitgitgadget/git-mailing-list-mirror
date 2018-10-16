Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC6F1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 09:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJPRro (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 13:47:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:41993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 13:47:43 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MexlN-1g18vA17gP-00Obc7; Tue, 16
 Oct 2018 11:58:01 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MexlN-1g18vA17gP-00Obc7; Tue, 16
 Oct 2018 11:58:01 +0200
Date:   Tue, 16 Oct 2018 11:58:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 06/13] Add a build definition for Azure DevOps
In-Reply-To: <xmqqsh16zc5x.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810161155030.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <1a22efe849d6da79f2c639c62a1483361a130238.1539598316.git.gitgitgadget@gmail.com> <xmqqsh16zc5x.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9Apckrsjn1bRf/7V5kVT374S0QBWMp7tX2Yz6MARryLOuVW0/s2
 LB4CGH+y5p8xnqwlb+8jdp+rix5cdgyWxowsrzorVnvfdwZImIIAkYm87i4TWiLDf0mzMke
 QjeqN2a2JRM/tzKpVgjhV7na8TnysP93Ffw8S+Zoc4fihSWXqOtXmrme5y2q701PptkLAEz
 uWiFamld8blijJQqMmRzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4PSYUX1A10g=:nqAKHngfR/05pG2wzeyvP/
 zGsOBPcOhZgPmszDYhBy5HS5S32cN2mRnrqhqX0bXB9UO/i9LYzUWsW8FHdzgnNKgVL4olVGX
 ogVzJf6x79w8PRqbVYtRiRyITPVTArx3dI2hFM5SeJBbomLSdIZGXt0fre9g8fz9fki6HoCyw
 cORFD2CCdxTBbv3yOybXy7kJgVjr4DNDAHrx9nQOeLVpYV5YsjqoyqpiRrP82vNSQzDI84biQ
 n2rkGktDgiJkMPvSbjyxU1IKz3/BNevDxOY2GzMNdIVhM8aC2//D5yK4s5eNPYiXDe2WCHPuv
 QrqKQlTp6oGQ86TmmMRRxhbn2glRic/1CAgGY6rQFoKXH1B1px61qZ+IT/x49+P+OK6F+ggi/
 3NpLhEH3Ag7PTpdacBaVYd7Mk6qAllhQ0jEuHUU4kcWRUa1lggvfIMFba2V3SMuj9Qg+rcpJe
 EnqkkMWrdO8tG53PdX1fl1O+9HVcltOikEmO87Bg8CkL2l1yUto5u5jAZW6UOB/7b/UwB0cM2
 1pEOX2QBgze/ppyqUrjEfr8t4D1wOeHCa7A42UWU4GXyf8pW+MCeu2gIywjlarIQfj0P7LH2I
 u3ZPnXvuvLr2HKkpiBSGoAZ8L843SJh4SJWHg5+aDF/oBZFgK/givGUEeGtPALAKyve2dPOPj
 IJX/2swVRXKj63OgOtUOuVtCRW6k9xpx64+A2W3oleWZxbvPoFMfotNJn4D5+qpAVyMK27B+C
 GTPjmOG4fa49nrGM1GS/Rhd0LoPyxlhmZuvZqaJfnz5vm/jwPixN4II9+9H5kmiUQ0sBTLlAw
 DFWgnKEYBwjA8Sa2w658L/zbCzGHacj6HeHnYaBqw8G2NuMqiU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 16 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Also, we make use of the shiny new feature we just introduced where the
> > test suite can output JUnit-style .xml files. This information is made
> > available in a nice UI that allows the viewer to filter by phase and/or
> > test number, and to see trends such as: number of (failing) tests, time
> > spent running the test suite, etc.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  azure-pipelines.yml   | 319 ++++++++++++++++++++++++++++++++++++++++++
> >  ci/mount-fileshare.sh |  26 ++++
> >  2 files changed, 345 insertions(+)
> >  create mode 100644 azure-pipelines.yml
> >  create mode 100755 ci/mount-fileshare.sh
> 
> I wonder if there is a need to keep what is tested by this and
> Travis in sync in any way, but most of the logic is not defined in
> these "steps" but implemented in ci/*.sh scripts to be shared, so it
> would be OK, I guess.

Indeed, that was my intention.

These ci scripts are not only useful for Travis and Azure Pipelines, after
all, but also a good documentation how to test locally. For example, to
repeat Luke's Perforce testing, I could simply use the URLs listed in
those ci scripts to get almost the same setup locally (close enough for
testing).

So it is not only about sharing, and ease of maintenance, but it is also
about documenting.

And yes, sharing means that we do not have to waste brain cycles on
keeping things in sync.

> > diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
> > new file mode 100755
> > index 0000000000..5fb5f74b70
> > --- /dev/null
> > +++ b/ci/mount-fileshare.sh
> > @@ -0,0 +1,26 @@
> > +#!/bin/sh
> > +
> > +die () {
> > +	echo "$*" >&2
> > +	exit 1
> > +}
> > +
> > +test $# = 4 ||
> > +die "Usage: $0 <share> <username> <password> <mountpoint"
> 
> Missing closing '>'.

Thanks!

> > +
> > +mkdir -p "$4" || die "Could not create $4"
> > +
> > +case "$(uname -s)" in
> > +Linux)
> > +	sudo mount -t cifs -o vers=3.0,username="$2",password="$3",dir_mode=0777,file_mode=0777,serverino "$1" "$4"
> > +	;;
> > +Darwin)
> > +	pass="$(echo "$3" | sed -e 's/\//%2F/g' -e 's/+/%2B/g')" &&
> > +	mount -t smbfs,soft "smb://$2:$pass@${1#//}" "$4"
> > +	;;
> > +*)
> > +	die "No support for $(uname -s)"
> > +	;;
> > +esac ||
> > +die "Could not mount $4"
> > +
> 
> Trailing blank line.
> 
> Thanks.

Thank you, both issues will be fixed in the next iteration,
Dscho
