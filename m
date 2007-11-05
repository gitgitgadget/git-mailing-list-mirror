From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] Cogito is deprecated, so don't point to it
Date: Mon, 05 Nov 2007 12:52:00 +0100
Message-ID: <874pg0c3kv.fsf@lysator.liu.se>
References: <20071105030608.6033.35208.stgit@yoghurt> <vpqejf510ci.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 12:52:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip0VH-0007Yd-IV
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 12:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbXKELwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 06:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbXKELwN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 06:52:13 -0500
Received: from main.gmane.org ([80.91.229.2]:35660 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbXKELwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 06:52:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ip0Uu-0003bl-J5
	for git@vger.kernel.org; Mon, 05 Nov 2007 11:52:04 +0000
Received: from c83-253-242-75.bredband.comhem.se ([83.253.242.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 11:52:04 +0000
Received: from davidk by c83-253-242-75.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 11:52:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-242-75.bredband.comhem.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:Y5qLR7V+hoZr7kWhve8nGzDOrfI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63498>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Karl Hasselstr=C3=B6m <kha@treskal.com> writes:
>
>> -directly). For standard SCM operations, either use plain GIT comman=
ds
>> -or the Cogito tool but it is not recommended to mix them with the
>> -StGIT commands.
>> +directly). For standard SCM operations, use plain GIT commands.
>
> Doesn't the "but it is not recommended to mix them with the StGIT
> commands." part still hold?

Karl has been working hard lately to make sure that stg doesn't get
confused when you use git directly.

--=20
David K=C3=A5gedal
