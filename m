From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/5] bash: refactor 'git log --pretty=<format>' options
Date: Fri, 16 Jan 2009 09:18:16 -0800
Message-ID: <20090116171816.GO10179@spearce.org>
References: <1232121735-10239-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 18:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNsMA-0008H9-45
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 18:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759624AbZAPRSS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 12:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759105AbZAPRSS
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 12:18:18 -0500
Received: from george.spearce.org ([209.20.77.23]:41295 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445AbZAPRSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 12:18:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D7E6B38210; Fri, 16 Jan 2009 17:18:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1232121735-10239-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105979>

SZEDER G=E1bor <szeder@ira.uka.de> wrote:
> Both 'git log' and 'show' have the same '--pretty=3D<format>' option
> with the same formats.  So refactor these formats into a common
> variable.
>=20
> While at it, also add 'format:' to the list.
>=20
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>

=46or all 3 patches in the series:

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks.

--=20
Shawn.
