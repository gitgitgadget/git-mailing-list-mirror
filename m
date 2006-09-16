From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: more support for PATH_INFO based URLs
Date: Sat, 16 Sep 2006 23:46:28 +0200
Organization: At home
Message-ID: <eehrad$5i0$2@sea.gmane.org>
References: <20060916210832.GV17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 16 23:50:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOi3L-0000w2-62
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 23:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWIPVuR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 16 Sep 2006 17:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWIPVuR
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 17:50:17 -0400
Received: from main.gmane.org ([80.91.229.2]:31952 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751813AbWIPVuP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 17:50:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GOi30-0000rP-Jp
	for git@vger.kernel.org; Sat, 16 Sep 2006 23:50:02 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 23:50:02 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 23:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27138>

Martin Waitz wrote:

> Now three types of path based URLs are supported:
> =A0=A0=A0=A0=A0=A0=A0=A0gitweb.cgi/project.git
> =A0=A0=A0=A0=A0=A0=A0=A0gitweb.cgi/project.git/branch
> =A0=A0=A0=A0=A0=A0=A0=A0gitweb.cgi/project.git/branch/filename
>=20
> The first one (show project summary) was already supported for a long=
 time
> now. =A0The other two are new: they show the shortlog of a branch or
> the plain file contents of some file contained in the repository.
>=20
> This is especially useful to support project web pages for small
> projects: just create an html branch and then use an URL like
> gitweb.cgi/project.git/html/index.html.

Very nice.

Acked-by: Jakub Narebski <jnareb@gmail.com>

(if it matters)
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
