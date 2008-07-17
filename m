From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 09:30:33 +0200
Message-ID: <487EF519.5070902@sneakemail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 09:31:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJNxo-0007Cj-JB
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 09:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759524AbYGQHaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 03:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759513AbYGQHai
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 03:30:38 -0400
Received: from morch.com ([193.58.255.207]:50171 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758093AbYGQHag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 03:30:36 -0400
Received: from [192.168.1.214] (ANice-157-1-140-70.w90-52.abo.wanadoo.fr [90.52.83.70])
	by morch.com (Postfix) with ESMTP id 0F4BF2831
	for <git@vger.kernel.org>; Thu, 17 Jul 2008 09:32:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88811>

Johannes Schindelin Johannes.Schindelin-at-gmx.de |Lists| wrote:
> there have been a number of occasions where I came across people tryi=
ng to=20
> be helpful and teaching Git newbies a few tricks.
>=20
> However, in quite a number of cases, which seem to surge over the las=
t=20
> weeks, I see people suggesting the use of rev-parse, ls-tree, rev-lis=
t=20
> etc.

As a total git newbie (5 days) coming from svn, I *am* bewildered. Even=
=20
sticking to porcelain, it is a feature-rich new tool I have in my hands=
!

I'm missing clarity about what is porcelain and what is plumbing. `git=20
help` shows

"The most commonly used git commands are:"  add .. tag.

Is this list exactly the list of porcelain commands? Then say so there.=
=20
Neither `git help diff` nor `git help ls-tree` say whether they are=20
porcelain or plumbing commands. `git help diff` mentions git-diff-index=
,=20
which i suspect is plumbing. When I read a man page, it would be nice t=
o=20
know whether a command (either the topic of the page or another=20
mentioned command) is intended as porcelain or not.

Also, I'm guessing that some switches for some porcelain commands have=20
plumbing purposes and vice versa. I hope not, but if so that would be=20
nice to have documented in 'git help *'

All of this of course assumes that there is consensus and a clear=20
distinction between what is porcelain and what is plumbing which I'm=20
don't even know if there is.

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
