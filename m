From: pocmatos@gmail.com (Paulo J. Matos)
Subject: Re: Import of svn rep has path issues
Date: Tue, 04 May 2010 10:01:57 +0100
Message-ID: <847hnk9h16.fsf@gmail.com>
References: <8439yblorn.fsf@gmail.com>
	<20100502081510.GF92627@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 11:02:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9E1C-00042G-NV
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 11:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233Ab0EDJCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 05:02:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:49761 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757170Ab0EDJCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 05:02:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O9E12-00040V-Va
	for git@vger.kernel.org; Tue, 04 May 2010 11:02:08 +0200
Received: from host86-146-157-21.range86-146.btcentralplus.com ([86.146.157.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 11:02:08 +0200
Received: from pocmatos by host86-146-157-21.range86-146.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 11:02:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: host86-146-157-21.range86-146.btcentralplus.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:gCKaQPMyNbebMYiNp1ZAPyTlHIY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146303>

Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:

>
> Well, just look at your git-repo then and see if the logs indicate th=
is
> file made it (I doubt it).
>

Indeed it didn't make it which is unfortunate.

> Please have a look at svn2git, which can take rules for what to do wi=
th
> specific paths at specific revisions. This should make it possible to=
 go
> from
>

Thanks for the svn2git ref. My issue seems to be that my svn rep has
been used for all sorts of stuff: docs, general files, source code and
therefore I have actually never followed the branches/, tags/, trunk/
git-svnimport requires. Do you know if svn2git allows you to import an
svn repository with all revisions as is even if they don't follow norma=
l
path conventions for software repositories?

Cheers,

--=20
PMatos
