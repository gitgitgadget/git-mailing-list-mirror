From: =?ISO-8859-1?Q?Peter_Valdemar_M=F8rch?= <lists@morch.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 15:35:22 +0200
Message-ID: <487F4A9A.1090108@morch.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <487EF519.5070902@sneakemail.com> <20080717125536.GO2167@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Jul 17 15:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJTxI-0000uY-Fh
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 15:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbYGQNyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 09:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756910AbYGQNyb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 09:54:31 -0400
Received: from morch.com ([193.58.255.207]:55972 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750AbYGQNyb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 09:54:31 -0400
X-Greylist: delayed 1144 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jul 2008 09:54:30 EDT
Received: from [192.168.1.214] (ANice-157-1-140-70.w90-52.abo.wanadoo.fr [90.52.83.70])
	by morch.com (Postfix) with ESMTP id 7AC64283E
	for <git@vger.kernel.org>; Thu, 17 Jul 2008 15:36:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080717125536.GO2167@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88852>

Theodore Tso tytso-at-mit.edu |Lists| wrote:
> The top-level man page has a listing of what is porcelain and what is
> plumbing --- although there is some disagreement.

Cool! I missed that! Thanks.

> Have you taken a look at the intro-level materials such as "Everyday
> Git in 20 commands or so"[1], the git tutorial[2], the official "Git'=
s
> User Manual"[3], or the "Git-SVN crash course"[4]?

Yup. I started there and am happily coding, committing, branching &=20
merging away. Now man pages are closest to my fingers in the terminal. =
:-)

E.g. something I seem to succeed with sometimes, but not consistently i=
s=20
the equivalent of "svn revert -R .". "git help reset"? Yup: "git reset=20
--hard HEAD ." When I run into merge conflicts, I'll probably look at=20
such a doc again, but other than that I'll probably use man pages most.

Just wanted to offer the newbie's opinion, that it would be helpful for=
=20
me with "Here be plumbing. Newbies look elsewhere" notices when I'm on=20
my way down the wrong track.

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
