From: Remi Vanicat <remi.vanicat@laposte.net>
Subject: Re: git rm --cached
Date: Sat, 03 Nov 2007 10:39:17 +0100
Organization: none
Message-ID: <87d4uris6y.dlv@vanicat.homelinux.org>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com> <87mytwiq1f.dlv@vanicat.homelinux.org> <20071102174140.vobtdjxfwsgoc040@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 10:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoFU0-0000K2-Cv
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 10:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbXKCJjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 05:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbXKCJjq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 05:39:46 -0400
Received: from main.gmane.org ([80.91.229.2]:44405 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbXKCJjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 05:39:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IoFTQ-0003D0-MP
	for git@vger.kernel.org; Sat, 03 Nov 2007 09:39:24 +0000
Received: from 77.193.75.123 ([77.193.75.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 09:39:24 +0000
Received: from remi.vanicat by 77.193.75.123 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 09:39:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 77.193.75.123
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:nyY6sb89ZPeU5e64fxAMVYBKrI8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63222>

Jing Xue <jingxue@digizenstudio.com> writes:

> 2. The FAQ entry "Why 'git rm' is not inverse of 'git add'" says "a
> natural inverse of 'add' is 'un-add', and that operation is called 'r=
m
> --cached',..."  Now I realize that only applies to adding a new file,
> but not changes on an existing file.

Well, so it seem that to think of "git rm --cached" as inverse to=20
"git add" is also confusing. The FAQ entry should probably be
rewrite. Or at least clarified.

=20

--=20
R=C3=A9mi Vanicat
