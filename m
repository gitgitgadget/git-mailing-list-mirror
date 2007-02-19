From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el won't run
Date: Mon, 19 Feb 2007 21:42:59 +0100
Message-ID: <87mz393mlo.fsf@morpheus.local>
References: <13283.1171492535@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 21:43:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJFMS-0006FF-GJ
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbXBSUnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Feb 2007 15:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbXBSUnp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:43:45 -0500
Received: from main.gmane.org ([80.91.229.2]:54961 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932633AbXBSUno (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:43:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJFLv-0003Yl-KZ
	for git@vger.kernel.org; Mon, 19 Feb 2007 21:43:15 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 21:43:15 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 21:43:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:In+T4zOMHvJd0FjsCB6ZmKfmIMs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40148>

Xavier Maillard <zedek@gnu.org> writes:

> Hi,
>
> I was happy to see that latest git's git included an emacs mode
> for git-blame.
>
> Sadly, when trying it, I just have this displayed into *Messages*
> buffer:=20
>
> Setting up indent for shell type bash
> setting up indent stuff
> Indentation variable are now local.
> Indentation setup for shell type bash
> let: Process git-blame not running

Can you please set debug-on-error to t and show me the backtrace you ge=
t?

And does M-! git-blame work in your emacs?

--=20
David K=C3=A5gedal
