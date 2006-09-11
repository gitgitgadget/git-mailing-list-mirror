From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Tue, 12 Sep 2006 00:14:12 +0200
Message-ID: <20060911221411.GG23891@pasky.or.cz>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net> <ee3hac$n57$1@sea.gmane.org> <7v7j0ajrfh.fsf@assigned-by-dhcp.cox.net> <ee4j3j$mli$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 00:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMu2j-00008E-LR
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 00:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWIKWOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 11 Sep 2006 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWIKWOO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 18:14:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26327 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964966AbWIKWOO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 18:14:14 -0400
Received: (qmail 5776 invoked by uid 2001); 12 Sep 2006 00:14:12 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ee4j3j$mli$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26863>

Dear diary, on Mon, Sep 11, 2006 at 11:06:03PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Junio C Hamano wrote:
>=20
> >> =A0* git-rev-list: --stdin to feed list of <commits>; it is not cl=
ear from=20
> >> =A0 =A0the manpage if one can use ^<commit>, and commit related op=
tions
> >> =A0 =A0and shortcuts like --not, <commit>..<commit>, <commit>...<c=
ommit>
> >> =A0* git-pack-objects: --revs to provide arguments to rev-list fro=
m stdin,
> >> =A0 =A0instead of list of objects. UNDOCUMENTED.
> >=20
> > Time spent whining about it is better spent finding it out
> > yourself (UTSL) and writing it I suspect. =A0You'll learn how
> > things actually work while doing so ;-).
>=20
> I still think it is better, easier and faster for someone who makes a=
 new
> feature to document it too.

Especially since we _DON'T_ have good track record in other people
quickly documenting newly introduced undocumented features.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
