From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.2.2
Date: Wed, 20 Jun 2007 10:34:57 +0200
Organization: At home
Message-ID: <f5aori$sj7$1@sea.gmane.org>
References: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 10:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0vel-00071R-Q0
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 10:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbXFTIfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Jun 2007 04:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXFTIfO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 04:35:14 -0400
Received: from main.gmane.org ([80.91.229.2]:59685 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbXFTIfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 04:35:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0vea-0004D5-L3
	for git@vger.kernel.org; Wed, 20 Jun 2007 10:35:04 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:35:04 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50547>

Junio C Hamano wrote:

> =A0 - git-gui is shipped with its updated blame interface. =A0It is
> =A0 =A0 rumored that the older one was not just unusable but was
> =A0 =A0 active health hazard, but this one is actually pretty.
> =A0 =A0 Please see for yourself.

I like the new interface very much, especially the info about who
made the change, and who moved the change to present place.

It would be nice though to have git-gui(1) man page describing 'blame'
subcommand of git-gui,, or have "git blame --gui" invoke "git gui blame=
".
gitk has it's manpage, why not git-gui? AFAICT there is currently no wa=
y to
discover this wonderfull tool given only manpages and git-gui help.

Perhaps file browser in git-gui should have "Blame"/"Annotate" button?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
