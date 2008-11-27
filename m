From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: remove dashed command leftovers
Date: Thu, 27 Nov 2008 13:24:30 -0800
Message-ID: <20081127212430.GA23984@spearce.org>
References: <1227792938-4006-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 22:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oMu-0000R1-Nf
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbYK0VYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 16:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbYK0VYc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:24:32 -0500
Received: from george.spearce.org ([209.20.77.23]:55189 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYK0VYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:24:31 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DC69838200; Thu, 27 Nov 2008 21:24:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1227792938-4006-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101837>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> Commit 5a625b07 (bash: remove fetch, push, pull dashed form leftovers=
,
> 2008-10-03) did that already, but there were still some git-cmd left
> here and there.
>=20
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

I really appreciate you taking the time to clean up existing code.
Its never fun, but it really helps to keep it from rotting.

> ---
>  contrib/completion/git-completion.bash |   41 ++++++----------------=
---------
>  1 files changed, 8 insertions(+), 33 deletions(-)

--=20
Shawn.
