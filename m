From: Peter Eriksen <s022018@student.dtu.dk>
Subject: Re: More precise tag following
Date: 31 Jan 2007 17:12:40 +0100
Message-ID: <m3abzz6upz.fsf@localhost.localdomain>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org> <87bqkf1tey.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 17:25:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCI7x-0008R8-Vv
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbXAaQQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 11:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbXAaQQB
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:16:01 -0500
Received: from main.gmane.org ([80.91.229.2]:50667 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030227AbXAaQQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:16:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCI7M-0006YA-Bg
	for git@vger.kernel.org; Wed, 31 Jan 2007 17:15:28 +0100
Received: from cpe.atm2-0-1071147.0x3ef2a7ea.boanxx10.customer.tele.dk ([62.242.167.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:15:28 +0100
Received: from s022018 by cpe.atm2-0-1071147.0x3ef2a7ea.boanxx10.customer.tele.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:15:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe.atm2-0-1071147.0x3ef2a7ea.boanxx10.customer.tele.dk
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38266>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Usage instructions:  Open a file and type M-x git-blame-mode
>=20
> ;;; git-blame.el

I saved the elisp code in a file .emacs.d/git-blame.el, and loaded it
with M-x load-file.  Then I visited git/cache.h, and typed M-x
git-blame-mode, but the background colours did not change.  What did I
forget to do?

Regards,

Peter
