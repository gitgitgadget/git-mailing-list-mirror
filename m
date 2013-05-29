From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] fixup! rebase: implement --[no-]autostash and rebase.autostash
Date: Wed, 29 May 2013 19:38:59 +0200
Message-ID: <vpq4ndlbs98.fsf@anie.imag.fr>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
	<1369825880-8608-1-git-send-email-artagnon@gmail.com>
	<7vzjvdu1y5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkLB-0007L1-M6
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934114Ab3E2RjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:39:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48475 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932730Ab3E2RjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:39:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4THcvbD017834
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 May 2013 19:38:57 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UhkKx-0004zf-SZ; Wed, 29 May 2013 19:38:59 +0200
In-Reply-To: <7vzjvdu1y5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 29 May 2013 10:32:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 May 2013 19:38:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4THcvbD017834
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1370453938.40043@Six/Z+KiDlmYo7K4r8dhlQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225850>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> For rr/rebase-autostash, which is stalled in pu.  See $gmane/225689.
>>
>> This is a super-minor fix anyway: if you disagree with something, change
>> it; there's no need to ask me.
>
> As I wasn't the one who were disagreeing, that would not work
> well.
>
> Was there anybody "disagreeing" in the first place?

I was the one suggesting the change, but I do not disagree with
anything ;-). The fixup is right.

I think Ramkumar was just saying "feel free to edit while applying", not
that there was any disagreement actually.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
