From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Showing abbreviated commit hash of the versions in Compare editor.
Date: Sat, 12 Jan 2008 16:44:19 +0100
Message-ID: <200801121644.21173.robin.rosenberg.lists@dewire.com>
References: <200801072315.30122.rogersoares@intelinet.com.br> <200801110046.41786.robin.rosenberg.lists@dewire.com> <47883600.20307@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sat Jan 12 16:45:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDiXl-00078B-Ez
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 16:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYALPoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 10:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbYALPoh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 10:44:37 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11418 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbYALPog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 10:44:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3DA768033A3;
	Sat, 12 Jan 2008 16:44:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSU55BCaRvym; Sat, 12 Jan 2008 16:44:34 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 9DB958030CD;
	Sat, 12 Jan 2008 16:44:32 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47883600.20307@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70326>

l=F6rdagen den 12 januari 2008 skrev Roger C. Soares:
>=20
> Robin Rosenberg escreveu:
> > I pushed my doc-branch as pu, you can look at it. My intention is t=
ake a look again
> > and then push it as master if there are no objections. Is it ok and=
 good to flags=20
> > public stuff without javadoc as an error (tip pu commit)?
> >  =20
> Got some errors, when trying to export to a deployable plugin:
> "/home/roger/eclipse/workspace/egit/org.spearce.jgit/tst" does not ex=
ist!
>=20
> And on "team -> share project... -> Git", it goes to the CVS wizard.

Due to my lack of testing @_@. I pushed a new pu branch with these two =
errors fixed.

Thanks
-- robin
