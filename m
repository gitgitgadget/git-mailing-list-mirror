From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] mergetool: put the cursor on the editable file for Vim
Date: Sun, 18 Jan 2009 15:18:54 +0100
Message-ID: <20090118141854.GA25155@neumann>
References: <200901172228.45450.markus.heidelberg@web.de>
	<7v7i4t4crp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYVr-0005xs-81
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761830AbZAROTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 09:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761746AbZAROTG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:19:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:53727 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761664AbZAROTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:19:05 -0500
Received: from [127.0.1.1] (p5B1346DD.dip0.t-ipconnect.de [91.19.70.221])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1LOYUI1z6W-0005xd; Sun, 18 Jan 2009 15:18:55 +0100
Content-Disposition: inline
In-Reply-To: <7v7i4t4crp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX18tPronSgrTJcmy7uC1Q3icFeK4rDjNnDyyWNl
 RqUlA00v14DtU6wdV/Xi5PtwIAeKiTZB85Z1LWeCoBlGNYZlM7
 q/lri3pKH7MR+GxQOarfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106189>

On Sat, Jan 17, 2009 at 05:35:22PM -0800, Junio C Hamano wrote:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
>=20
> > When resolving conflicts, you only need to edit the $MERGED file. P=
ut
> > the cursor automatically into its window for vimdiff and gvimdiff t=
o
> > avoid doing <C-w>l every time.
>=20
> I think this is sensible.
>=20
> I do not use vim, and I do not know if the patch does what it claims =
to
> do, though.

It does.

Tested-by: SZEDER G=E1bor <szeder@ira.uka.de>
