From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 11:53:57 +0100
Message-ID: <200802241153.58009.robin.rosenberg.lists@dewire.com>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com> <200802241100.00107.robin.rosenberg.lists@dewire.com> <m3wsoubqmq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 11:54:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTEVN-0004PL-KL
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 11:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbYBXKyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 05:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYBXKyL
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 05:54:11 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12406 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbYBXKyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 05:54:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 561C0802677;
	Sun, 24 Feb 2008 11:54:07 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FrKMpLh0LYiN; Sun, 24 Feb 2008 11:54:06 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E5CCA80264D;
	Sun, 24 Feb 2008 11:54:06 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <m3wsoubqmq.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74924>

s=F6ndagen den 24 februari 2008 skrev Jakub Narebski:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
>=20
> > s=F6ndagen den 24 februari 2008 skrev Nguyen Thai Ngoc Duy:
> > > I'm going to implement subtree checkout. The plan is to save "ind=
ex
> > > prefix" in GIT_DIR/prefix and update git commands to use index pr=
efix
> > > when accessing the index. If I'm heading a wrong way, stop me now=
=2E
> >=20
> > Make it multivalue as having more than one directory checked out is
> > quite reasonable in for example Eclipse, where there are hundreds o=
f
> > plugins all listed at the top level, but you only need a checkout
> > for those that you actually want to change. KDE would be another
> > example where you want to mention multiple roots.
>=20
> IMHO both in case of Eclipse plugins, and KDE modules/apps/whatever
> it would be much better to use submodules support than partial
> checkouts.

400 submodules... noway.

-- robin
