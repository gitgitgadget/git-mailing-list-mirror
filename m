From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el won't run
Date: Tue, 20 Feb 2007 18:34:45 +0100
Message-ID: <87fy9020ne.fsf@morpheus.local>
References: <13283.1171492535@localhost> <87mz393mlo.fsf@morpheus.local> <24475.1171920735@localhost> <87abz92rp9.fsf@morpheus.local> <4157.1171992534@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 18:35:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJYtT-0005Nt-LA
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 18:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbXBTRfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Feb 2007 12:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXBTRfF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 12:35:05 -0500
Received: from main.gmane.org ([80.91.229.2]:33584 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932585AbXBTRfD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 12:35:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJYtF-0001vd-VS
	for git@vger.kernel.org; Tue, 20 Feb 2007 18:34:57 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 18:34:57 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 18:34:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:Lm0aTXcBm3VUW7EFmU4P+HoBnGI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40244>

Xavier Maillard <maillaxa@gmail.com> writes:

> Hi,
>
>> >> Can you please set debug-on-error to t and show me the backtrace =
you get?
>> >
>> > Nothing happens. I have to C-g after having waited for a few
>> > seconds.
>>=20
>> I'm not sure my instructions were very clear.  Did you try M-x
>> git-blame-mode after enabling debug-on-error?
>
> I did it. And I had to kill (C-g) after having waited for several
> long seconds.

OK, then set debug-on-quit to t and do it again, and send me the
backtrace you get when you press C-g.

--=20
David K=C3=A5gedal
