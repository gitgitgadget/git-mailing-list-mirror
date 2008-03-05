From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] bash: git-branch -d and -m lists only local branches
Date: Wed, 5 Mar 2008 00:51:38 -0500
Message-ID: <20080305055138.GC8410@spearce.org>
References: <d55a578b4b3f3b7d679b7f8b69497955c7a82a50.1204652001.git.szeder@ira.uka.de> <4fffe1c7adc092af695610a87f97c8684ae0eea6.1204652001.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:52:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWmYI-0004r4-HM
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763270AbYCEFvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 00:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763244AbYCEFvt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:51:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33516 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763192AbYCEFvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 00:51:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWmXT-0001cS-BL; Wed, 05 Mar 2008 00:51:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6769420FBAE; Wed,  5 Mar 2008 00:51:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4fffe1c7adc092af695610a87f97c8684ae0eea6.1204652001.git.szeder@ira.uka.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76175>

SZEDER Gbor <szeder@ira.uka.de> wrote:
> But still all branches are listed, if -r is present
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Nice.

Both patches 1 and 2,
Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)

--=20
Shawn.
