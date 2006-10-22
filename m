From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] New stg command: assimilate
Date: Sun, 22 Oct 2006 19:43:08 +0200
Message-ID: <20061022174308.GQ20017@pasky.or.cz>
References: <20061022130559.17015.51385.stgit@localhost> <20061022130802.17015.50188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 19:43:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbhM1-0003yL-Sv
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 19:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWJVRnK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 13:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWJVRnK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 13:43:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30618 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751787AbWJVRnJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 13:43:09 -0400
Received: (qmail 13424 invoked by uid 2001); 22 Oct 2006 19:43:08 +0200
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Content-Disposition: inline
In-Reply-To: <20061022130802.17015.50188.stgit@localhost>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29768>

Dear diary, on Sun, Oct 22, 2006 at 03:08:02PM CEST, I got a letter
where Karl Hasselstr=F6m <kha@treskal.com> said that...
> From: Karl Hasselstr=F6m <kha@treskal.com>
>=20
> Introduce an "assimilate" command, with no options. It takes any GIT
> commits committed on top of your StGIT patch stack and converts them
> into StGIT patches.

Hmm, isn't this what stg uncommit does?

Well, I'm not sure if what uncommit takes is from below the stack or
above the stack, but if it's the former, it would still IMHO make more
sense to just tell that StGIT with a switch or something.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=3Dpack('H*',/((..)*)$/)
