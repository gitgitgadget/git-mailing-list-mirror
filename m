From: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
Subject: Re: [PATCH] send-email: support NNTP
Date: Thu, 25 Apr 2013 09:02:08 +0200
Message-ID: <87li87hz4f.fsf@samsung.com>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<87zjwofken.fsf@linux-k42r.v.cablecom.net>
	<7v38ufa6wb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 09:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVGCE-0006dR-JU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 09:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab3DYHCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 03:02:18 -0400
Received: from plane.gmane.org ([80.91.229.3]:36306 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab3DYHCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 03:02:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UVGC6-0006QM-J9
	for git@vger.kernel.org; Thu, 25 Apr 2013 09:02:14 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 09:02:14 +0200
Received: from l.stelmach by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 09:02:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 217-67-201-162.itsa.net.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Cancel-Lock: sha1:ADD9H3mo1IKQp3kknwo+XxvbK2Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222349>

It was <2013-04-25 czw 00:41>, when Junio C Hamano wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> =C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:
>>
>>> Enable sending patches to NNTP servers (Usenet, Gmane).
>>
>> I'm surprised Junio didn't mention this: your patch lacks the
>> Signed-off-by.
>
> Heh, that was because I took the patch as an early preview and not a
> final submission.  It came without documentation updates, and also
> it seemed to break t9001 for whatever reason.

I suppose that means I should write tests too. OK.

--=20
=C5=81ukasz Stelmach
Software wizzard
Samsung Poland R&D Center
