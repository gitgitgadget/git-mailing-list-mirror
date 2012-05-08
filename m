From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 08 May 2012 19:33:41 +0200
Message-ID: <m2aa1ih91m.fsf@igel.home>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
	<7v4nrqy6ur.fsf@alter.siamese.dyndns.org>
	<CABPQNSb-YPAa6qPtxeo1k-p-0REnk3soOTuPgABj9+s61o80VA@mail.gmail.com>
	<7vwr4mwrq6.fsf@alter.siamese.dyndns.org>
	<CABPQNSYLLSsfAumjk0_RGBPbbV4=vFWVFAn13ZLwq_vm01+M4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j.sixt@viscovery.net
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 19:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoIJ-0001zM-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab2EHRdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 13:33:47 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56942 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2EHRdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:33:46 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Vn78j35rzz3hhfW;
	Tue,  8 May 2012 19:33:41 +0200 (CEST)
Received: from igel.home (ppp-93-104-129-118.dynamic.mnet-online.de [93.104.129.118])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Vn78j4Flyz4KK2s;
	Tue,  8 May 2012 19:33:41 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 31ADCCA2A9; Tue,  8 May 2012 19:33:41 +0200 (CEST)
X-Yow: BEEP-BEEP!!  I'm a '49 STUDEBAKER!!
In-Reply-To: <CABPQNSYLLSsfAumjk0_RGBPbbV4=vFWVFAn13ZLwq_vm01+M4Q@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 8 May 2012 18:43:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197399>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> It's the name we Windows users tend to use for what you unix-guys tend
> to call "libc" ;)

I think it originated in Unix, viz /usr/lib/crt0.o.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
