From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Unable to remove a file
Date: Tue, 04 Oct 2011 16:50:43 +0200
Message-ID: <m3k48ku7y4.fsf@hase.home>
References: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>
	<m262k6jc2c.fsf@igel.home>
	<CAAZ43xa43YjO7Vqw87cYnXhJWvsZT_ocPpLuJ81jCPc8KKRczw@mail.gmail.com>
	<4E8ABC85.7090705@in.waw.pl>
	<CAEBDL5U4gU9C0De42Sgqv1ODLwQBuOdYdhfTBCMUziCZrhK9dA@mail.gmail.com>
	<CAAZ43xZo8cyE_ASz1Hc4yYoUjmH1OnVogOj6mtqFzmAUSBptFw@mail.gmail.com>
	<4E8B135D.8090507@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: robert mena <robert.mena@gmail.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Oct 04 16:50:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB6Ka-0000u9-Ik
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 16:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab1JDOup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 10:50:45 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45528 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141Ab1JDOuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 10:50:44 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 87968182447D;
	Tue,  4 Oct 2011 16:50:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A78181C001A6;
	Tue,  4 Oct 2011 16:50:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 1bxcwVBO4neR; Tue,  4 Oct 2011 16:50:41 +0200 (CEST)
Received: from hase.home (ppp-88-217-110-127.dynamic.mnet-online.de [88.217.110.127])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue,  4 Oct 2011 16:50:40 +0200 (CEST)
X-Yow: What PROGRAM are they watching?
In-Reply-To: <4E8B135D.8090507@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?=
	message of "Tue, 04 Oct 2011 16:08:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182772>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> git fetch updates the remote references, always.

Only if the refspec starts with '+'.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
