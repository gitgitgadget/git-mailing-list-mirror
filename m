From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-grep: small suggestion, -w flag
Date: Sun, 22 Feb 2009 12:15:21 +0100
Message-ID: <49A133C9.2030601@lsrfire.ath.cx>
References: <20090222103448.GA32119@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Feb 22 12:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbCKU-00089P-Ge
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 12:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbZBVLPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 06:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZBVLPe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 06:15:34 -0500
Received: from india601.server4you.de ([85.25.151.105]:35634 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbZBVLPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 06:15:33 -0500
Received: from [10.0.1.101] (p57B7FB38.dip.t-dialin.net [87.183.251.56])
	by india601.server4you.de (Postfix) with ESMTPSA id 203BF2F8065;
	Sun, 22 Feb 2009 12:15:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090222103448.GA32119@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110996>

Ingo Molnar schrieb:
> Here's a stupid little git-grep suggestion.
>=20
> I recently transitioned from the use of egrep to git-grep, and i=20
> like it very much (it nicely excludes build related files,=20
> etc.), but there's one small detail: the lack of the -w flag.

git grep knows this flag since version 1.4.1.  Does it do something
different from egrep's?

Ren=E9
