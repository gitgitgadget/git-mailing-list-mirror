Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F7F2036C
	for <e@80x24.org>; Wed,  4 Oct 2017 23:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdJDX3h (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 19:29:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:64874 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbdJDX3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 19:29:35 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPD8G-1dvVNt0PmC-004VDU; Thu, 05
 Oct 2017 01:29:33 +0200
Date:   Thu, 5 Oct 2017 01:29:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Andr=C3=A9_Netzeband?= <andre@netzeband.eu>
cc:     git@vger.kernel.org
Subject: Re: cmd.exe Terminal is closing when cloning a repository on windows
 10 (64.bit)
In-Reply-To: <5aa837bb-04ae-d80d-3a91-53d06fd7456f@netzeband.eu>
Message-ID: <alpine.DEB.2.21.1.1710050128410.40514@virtualbox>
References: <5aa837bb-04ae-d80d-3a91-53d06fd7456f@netzeband.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-391630432-1507159773=:40514"
X-Provags-ID: V03:K0:n4i8R0lx0s2jh5FLiDkg0eJX3nqzL56BSYretmN1ogWnQDIqEU9
 m+hCdZFC2me1XVPxOP3O9Lmt1X2ucjyICrqtUs7+8mql+FF8luza+jIpDpzp/bw9EdgwwTl
 4hIHLz3mei1nAJha8zs8HqKldD7wl6/NHOiHqpCiJOx7KOFgt6sKQqmbOvYlknA3dl2AAD6
 DHRcB/IAtdcbamiu25ujw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oIXPcbIICwM=:TTvmLdyfpPRXMH8ufbRW8a
 Uai/kbQzcReg/FjFViU1UViFVmYJid+M3+3dkay3ycH1HYOv9CTG2Ybwpkkro+nv/7tMUnAsE
 M+SMa6+Og7ezOvSu/tA4ZUlC/7NsDKwJVgqZyeDfLgQITmTco7/hUXWghdCWA0yRPKZrK1aH3
 OxwIOlcGlSn6eFGx908MLH0IIy0tzGRoMDmku7U8EgWRMkoE5ZfOiR3mkvwae7XmlhSSw1gVF
 ChKRisIilr+C26AYe8YLFpr4SMIEo+ivT8fi6Psh3kpXecWh39H3d6340DHy6pUI7BfICQ4Cm
 rB2+Exqho9g3OC2kIjacaY9dRz1oX1/hlFhkaNCbZOYYVtoyJmKfUUFlfD9JcSbAWVv5Xf3bi
 I0vxS2frxcBvBt8toX8Wj3f+9BsYatqsukBsvittsBk4oSC4HmSDUTn3C/rDeqyNit0WSuA0l
 2oG/C795y8Q7wEaKsdPu/wc16BWL7vM52Zrue9cEOmEkQb5FhlmWvwzfUP+wkouSBS1XQ2PAc
 BOcS5dGVs+gdQjN/osTSWGwsaMHD78+3nTcBUvSchuElPBWHz2xDaK9RbRcWCROKkEha4SAwW
 bqMhKMZqEGPTSET0OLVYQThyz3m0rcqQuOiArowjf+hlRHOaasfSsZVKeecTGQzSQzOX/jWmE
 AQ0luSnPEUbaC+cEyJHQky6gGOSnRnpcksxboGXSWi0B5Y2H5ny4gI9Mx9vqY0KjbXOdfxUZP
 RaFZQ+1/2RDXuUsaTO3elQVRYCRw2WHz133fP+YEDLorNgyp7f2sQipZZ0eQL44jVhn55h2fn
 FY1MRfKLEsgD2ugDEdGPAHMXC2Ei/nvfYIfy9JNYXiFRIBiuXo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-391630432-1507159773=:40514
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Andr=C3=A9,

On Mon, 2 Oct 2017, Andr=C3=A9 Netzeband wrote:

> I installed git for windows 2.14.2 (64bit) and was trying to clone a
> repository from a command terminal (cmd.exe):
>=20
> git clone https://Netzeband@bitbucket.org/Netzeband/deep-speeddreams.git
>=20
> First everything went well, but after the repository was downloaded the L=
FS
> download started. At this point the terminal window just closed and I was=
 not
> able to see anything related on the terminal. There was no error message.
> However several git processes (and git lfs) were running in the backgroun=
d and
> downloaded everything for the repository (all lfs files).
>=20
> The same happens if I use the git-bash.
>=20
> After switching back to 2.13.0 with the same settings during installation=
,
> this error did not occur again.
>=20
> I'm using Windows 10 (b4 bit) which all current updates installed.

This is most likely the same issue as reported at
https://github.com/git-lfs/git-lfs/issues/2631 and at
https://github.com/git-for-windows/git/issues/1312.

Ciao,
Johannes
--8323329-391630432-1507159773=:40514--
