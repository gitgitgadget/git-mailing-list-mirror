From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT] fnmatch Implementation.
Date: Wed, 18 Jun 2008 20:43:42 +0200
Message-ID: <200806182043.43321.robin.rosenberg.lists@dewire.com>
References: <4858DFA2.30203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, galder.zamarreno@redhat.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Florian =?iso-8859-1?q?K=F6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:48:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K92hf-0004vZ-Er
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 20:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbYFRSrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 14:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbYFRSrZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 14:47:25 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:38647 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbYFRSrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 14:47:24 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 85546383FE; Wed, 18 Jun 2008 20:47:22 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 61E7D37F0E; Wed, 18 Jun 2008 20:47:22 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id C0A6F37E44;
	Wed, 18 Jun 2008 20:47:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4858DFA2.30203@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85397>

onsdagen den 18 juni 2008 12.12.50 skrev Florian K=F6berle:
> Hi,
>=20
> when I send a large list of patches and one is wrong then you don't
> accept any. That's why I now will try to get one patch in before I se=
nd
> the next one.
Patience please. When there is long series it *will* take time for
a number of reasons. Most have nothing to do with this project at all. =
But in
general you will  find a short patch series  *much* easier to get throu=
gh than=20
a long one.

If you think my grouping is ok, then ack and I can commit from there. I
was thinking of actually adding some test myself, but that's all I had =
in mind.

> The first patch I will commit this way is the fnmatch patch.
>=20
> As suggested by Robin I replaced unicode characters not included in t=
he
> ASCII set with \uXXXX sequences.
>=20
> I also added some more test cases and improved the javadoc of the
> FileNameMatcher class.
That's good.

>=20
> Best regards,
> Florian
>
