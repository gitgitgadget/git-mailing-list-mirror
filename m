From: Insitu <abailly@oqube.com>
Subject: Re: Newbie problem
Date: Sat, 28 Jul 2007 10:50:04 +0200
Organization: OQube
Message-ID: <87myxgx683.fsf@osquare.oqube.com>
References: <87vec5vvt5.fsf@osquare.oqube.com>
	<7vmyxht0r6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 10:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEi5F-00040J-P8
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154AbXG1Iza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 Jul 2007 04:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757132AbXG1Iza
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:55:30 -0400
Received: from main.gmane.org ([80.91.229.2]:52836 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035AbXG1Iz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 04:55:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEi53-0007Wc-Rw
	for git@vger.kernel.org; Sat, 28 Jul 2007 10:55:21 +0200
Received: from abailly.pck.nerim.net ([213.41.244.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 10:55:21 +0200
Received: from abailly by abailly.pck.nerim.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 10:55:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: abailly.pck.nerim.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:ifODv4ieZmnimaowGQOB8J/GZnU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54012>

Junio C Hamano <gitster@pobox.com> writes:

>
>  [remote "origin"]
>      url =3D satellite:.git/
>      fetch =3D +refs/heads/*:refs/remotes/origin/*
>      push =3D refs/heads/*:refs/remotes/origin/*
>  [branch "master"]
>      remote =3D origin
>      merge =3D refs/heads/master
>
> On satellite laptop, in .git/config:
>
>  [remote "origin"]
>      url =3D mothership:.git/
>      fetch =3D +refs/heads/*:refs/remotes/origin/*
>      push =3D refs/heads/*:refs/remotes/origin/*
>  [branch "master"]
>      remote =3D origin
>      merge =3D refs/heads/master
>

Thanks a lot for all these details !=20

Yes, I also find Git very well
documented (maybe too much docuemented :) )  and could have come to
the settings with info from the various man pages. But much less
quickly of course.

My question is: can I do this right now that my repositories are up
and running ?=20

Regards,
--=20
OQube < software engineering \ g=E9nie logiciel >
Arnaud Bailly, Dr.
\web> http://www.oqube.com
