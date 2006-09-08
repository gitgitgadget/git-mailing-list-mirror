From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add git-archive [take #2]
Date: Fri, 08 Sep 2006 10:47:07 +0200
Organization: At home
Message-ID: <edrald$87p$1@sea.gmane.org>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>	<44FED12E.7010409@innova-card.com>	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>	<44FFD00E.5040305@innova-card.com>	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>	<450019C3.4030001@innova-card.com> <7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net> <45012752.4070300@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 08 10:47:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLc1B-00022z-Qk
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWIHIrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 04:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWIHIrA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:47:00 -0400
Received: from main.gmane.org ([80.91.229.2]:60038 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750704AbWIHIrA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 04:47:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLc0i-0001x6-Mo
	for git@vger.kernel.org; Fri, 08 Sep 2006 10:46:52 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 10:46:52 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 10:46:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26687>

=46ranck Bui-Huu wrote:

>> Especially tar-tree --remote and upload-archive talks different
>> protocols, so it is not like not removing it is making your life
>> more difficult. =A0Perhaps after next release (1.4.3 or 1.5? =A0I
>=20
> since you removed 'git-upload-tar', it would be good to remove
> '--remote' option from 'git-tar-tree' command as well.=20

git-tar-tree --remote was talked about, so I'd rather have the removal =
of
this option was postponed.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
