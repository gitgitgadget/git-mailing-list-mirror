From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Mon, 11 Sep 2006 23:06:03 +0200
Organization: At home
Message-ID: <ee4j3j$mli$1@sea.gmane.org>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net> <ee3hac$n57$1@sea.gmane.org> <7v7j0ajrfh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 11 23:07:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMsza-0003Z9-Q3
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 23:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWIKVGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 11 Sep 2006 17:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWIKVGg
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 17:06:36 -0400
Received: from main.gmane.org ([80.91.229.2]:23939 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965027AbWIKVGf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 17:06:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMsyv-0003Sa-L6
	for git@vger.kernel.org; Mon, 11 Sep 2006 23:06:17 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 23:06:17 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 23:06:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26858>

Junio C Hamano wrote:

>> =A0* git-rev-list: --stdin to feed list of <commits>; it is not clea=
r from=20
>> =A0 =A0the manpage if one can use ^<commit>, and commit related opti=
ons
>> =A0 =A0and shortcuts like --not, <commit>..<commit>, <commit>...<com=
mit>
>> =A0* git-pack-objects: --revs to provide arguments to rev-list from =
stdin,
>> =A0 =A0instead of list of objects. UNDOCUMENTED.
>=20
> Time spent whining about it is better spent finding it out
> yourself (UTSL) and writing it I suspect. =A0You'll learn how
> things actually work while doing so ;-).

I still think it is better, easier and faster for someone who makes a n=
ew
feature to document it too.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
