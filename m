From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] bash: add missing 'git merge' options
Date: Mon, 16 Feb 2009 07:56:46 -0800
Message-ID: <20090216155646.GB18525@spearce.org>
References: <7v7i3sp8jk.fsf@gitster.siamese.dyndns.org> <1234704311-14774-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:58:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5rL-0000eu-92
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbZBPP4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 10:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZBPP4r
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:56:47 -0500
Received: from george.spearce.org ([209.20.77.23]:43273 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbZBPP4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:56:47 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B96238211; Mon, 16 Feb 2009 15:56:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234704311-14774-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110197>

SZEDER G=E1bor <szeder@ira.uka.de> wrote:
> Namely: '--commit', '--stat', '--no-squash', '--ff', '--no-ff'.
>=20
> One might wonder why add options that specify the default behaviour
> anyway (e.g. '--commit', '--no-squash', etc.).  Users can override th=
e
> default with config options (e.g. 'branch.<name>.mergeoptions',
> 'merge.log'), but sometimes might still need the default behaviour.
>=20
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> ---

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>  contrib/completion/git-completion.bash |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

--=20
Shawn.
