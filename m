From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 19:15:08 +0100
Message-ID: <87lkk17c5v.fsf@morpheus.local>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> <87ps9d7j6t.fsf@morpheus.local> <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 17 19:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7FLh-0007Y2-I4
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 19:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbXAQSRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 13:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbXAQSRV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 13:17:21 -0500
Received: from main.gmane.org ([80.91.229.2]:54023 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932608AbXAQSRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 13:17:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H7FKM-0000cp-08
	for git@vger.kernel.org; Wed, 17 Jan 2007 19:16:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 19:16:01 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 19:16:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:5OWWsSFIWgEUDzOm0oWDl7sv614=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37024>

Junio C Hamano <junkio@cox.net> writes:

> Emacs wanted to go into its "diff" mode when files are named with
> .patch suffix,=20

This is probably the primary reason why I *want* it to be .patch.  The
diff-mode in Emacs is really useful, and read-write mode is only a C-x
C-q away.

> which had two annoyances (read-only by default, and
> editing patch tried to automatically recount diff and its recounting
> screwed up in some cases I do not remember the details about).

I rarely edit patches, but it has worked for me.

--=20
David K=C3=A5gedal
