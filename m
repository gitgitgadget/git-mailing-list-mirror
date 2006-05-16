From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gateway status?
Date: Tue, 16 May 2006 15:54:14 +0200
Organization: At home
Message-ID: <e4cli6$abe$1@sea.gmane.org>
References: <Pine.LNX.4.62.0605151122500.29452@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue May 16 16:09:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg09W-0006Sv-GM
	for gcvg-git@gmane.org; Tue, 16 May 2006 16:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWEPODc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 May 2006 10:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWEPODc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 10:03:32 -0400
Received: from main.gmane.org ([80.91.229.2]:11435 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751108AbWEPODb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 10:03:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fg03s-000502-Jw
	for git@vger.kernel.org; Tue, 16 May 2006 15:58:08 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 May 2006 15:58:08 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 May 2006 15:58:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20123>

David Lang wrote:

> I seem to remember seeing discussion of gateways to cvs/svn that woul=
d let=20
> a project use a git repository and allow clients to use cvs/svn clien=
ts to=20
> retreive data.
>=20
> am I remembering correctly, and are these tools ready for production =
use?=20


Eric Wong <normalperson@yhbt.net> wrote:
in "[0/2 PATCH] git-svn 1.0.0 release" thread
http://permalink.gmane.org/gmane.comp.version-control.git/19644

> It's been very solid for a long time now.=A0=A0I=A0haven't=A0run=A0in=
to
> any problems with it myself in a while, and no critical bugs
> that I know of exist.=A0=A0Labeling=A0it=A01.0.0=A0may=A0make=A0it=A0=
look
> less scary to new users :)

So I guess yes, they are.


P.S. IIRC git-cvsserver is used as temporary "Git plugin" for Eclipse, =
and
there are some problems with that due to the cvs client/server
implementation in Eclipse.

--=20
Jakub Narebski
Warsaw, Poland
