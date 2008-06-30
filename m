From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/7] Documentation: fix links to tutorials and other new manual pages
Date: Tue, 1 Jul 2008 01:30:31 +0200
Message-ID: <200807010130.31258.chriscool@tuxfamily.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu> <Pine.GSO.4.62.0806301657320.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@jdl.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:27:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSms-0007b1-1t
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYF3X0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbYF3X0g
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:26:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52575 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbYF3X0f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 19:26:35 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8CC2A1AB2BB;
	Tue,  1 Jul 2008 01:26:34 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0EAF21AB2B0;
	Tue,  1 Jul 2008 01:26:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <Pine.GSO.4.62.0806301657320.7190@harper.uchicago.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86964>

Le mardi 1 juillet 2008, Jonathan Nieder a =E9crit :
> With the conversion of HTML documentation to man pages
>
> tutorial.html -> gittutorial (7)
> tutorial-2.html -> gittutorial-2 (7)
> cvs-migration.html -> gitcvs-migration (7)
> diffcore.html -> gitdiffcore (7)
> repository-layout.html -> gitrepository-layout (5)
> hooks.html -> githooks (5)
> glossary.html -> gitglossary (7)
> core-tutorial.html -> gitcore-tutorial (7)
>
> and the automatic update of references to these pages,
> a little debris was left behind. We clear it away.

I left them behind because I thought they might be usefull and in fact =
in=20
some places you also leave them like this:

> -to start with linkgit:gittutorial[7][a tutorial introduction to git]
> +to start with "A Tutorial Introduction to GIT" (linkgit:gittutorial[=
7])

I understand that some people might prefer your version though.

Thanks,
Christian.
