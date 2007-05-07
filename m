From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Mon, 07 May 2007 02:59:56 +0200
Organization: At home
Message-ID: <f1ltdu$p1u$1@sea.gmane.org>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net> <1177662893872-git-send-email-junkio@cox.net> <7v4pmzdo9o.fsf@assigned-by-dhcp.cox.net> <7vejlucozk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 02:56:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkrWF-00059L-Uq
	for gcvg-git@gmane.org; Mon, 07 May 2007 02:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbXEGAzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 20:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXEGAzq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 20:55:46 -0400
Received: from main.gmane.org ([80.91.229.2]:45831 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbXEGAzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 20:55:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HkrVo-0003Jc-SS
	for git@vger.kernel.org; Mon, 07 May 2007 02:55:36 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 02:55:36 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 May 2007 02:55:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46402>

Junio C Hamano wrote:

> =A0 - "git diff $commit1:$path2 $commit2:$path2" can now report
> =A0 =A0 mode changes between the two blobs.

I think that actually it is enough to have $tree1:$path1 $tree2:$path2
(and it should be $commit1:$path1 not $path2 nevertheless).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
