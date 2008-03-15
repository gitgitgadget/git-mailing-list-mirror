From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update Japanese translation
Date: Sat, 15 Mar 2008 01:08:40 -0400
Message-ID: <20080315050840.GF8410@spearce.org>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 06:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaOe3-0001vK-C6
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 06:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbYCOFIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2008 01:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYCOFIo
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 01:08:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60513 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbYCOFIn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2008 01:08:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JaOdN-0000Si-Ox; Sat, 15 Mar 2008 01:08:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7B98720FBAE; Sat, 15 Mar 2008 01:08:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77310>

 <nanako3@bluebottle.com> wrote:
> I updated Japanese translation for the latest git-gui.
>=20
> Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=
=E3=81=93 <nanako3@bluebottle.com>
> ---
>  po/ja.po |  126 ++++++++++++++++++++++++++++++++++++++++++++++------=
----------
>  1 files changed, 94 insertions(+), 32 deletions(-)
>=20
> diff --git a/po/ja.po b/po/ja.po
> index e2cf5bd..189b726 100644
> --- a/po/ja.po
> +++ b/po/ja.po
> @@ -8,8 +8,8 @@ msgid ""
>  msgstr ""
>  "Project-Id-Version: git-gui\n"
>  "Report-Msgid-Bugs-To: \n"
> -"POT-Creation-Date: 2007-11-24 10:36+0100\n"
> -"PO-Revision-Date: 2007-12-05 06:12+0900\n"
> +"POT-Creation-Date: 2008-02-16 21:24+0100\n"
> +"PO-Revision-Date: 2008-03-14 20:32+0900\n"

Unfortunately this patch does not apply after Peter's regeneration
of the POT file (0212242d66):

  "POT-Creation-Date: 2008-03-14 07:18+0100\n"

I certainly can fix up a merge conflict in the header, but I do not
dare try to fix up the merge conflicts in the lower parts, where
there are actual Japanese translations.  Would you please be so kind
as to fetch my lastest master branch and submit an updated patch?

--=20
Shawn.
