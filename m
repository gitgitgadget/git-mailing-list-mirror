From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: More precise tag following
Date: Wed, 31 Jan 2007 18:04:40 +0100
Message-ID: <87y7nj161j.fsf@morpheus.local>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org> <87bqkf1tey.fsf@morpheus.local> <m3abzz6upz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 18:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIto-0001V1-Fc
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 18:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbXAaRF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 12:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbXAaRF3
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 12:05:29 -0500
Received: from main.gmane.org ([80.91.229.2]:49356 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030256AbXAaRF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 12:05:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCItT-0007yW-M4
	for git@vger.kernel.org; Wed, 31 Jan 2007 18:05:11 +0100
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 18:05:11 +0100
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 18:05:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:fdkODjVf7duWQWvx7AkcY/E2RM0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38278>

Peter Eriksen <s022018@student.dtu.dk> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Usage instructions:  Open a file and type M-x git-blame-mode
>>=20
>> ;;; git-blame.el
>
> I saved the elisp code in a file .emacs.d/git-blame.el, and loaded it
> with M-x load-file.  Then I visited git/cache.h, and typed M-x
> git-blame-mode, but the background colours did not change.  What did =
I
> forget to do?

Probably you forgot to use the latest version :-)

See my mail with the subject line "git-blame.el".

--=20
David K=C3=A5gedal
