From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 02 Oct 2012 19:25:51 +0200
Message-ID: <vpqa9w49468.fsf@grenoble-inp.fr>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
	<CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
	<CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
	<CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com>
	<vpqwqz89617.fsf@grenoble-inp.fr>
	<7v8vboaiy2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:26:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ6EX-00046G-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab2JBRZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 13:25:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44002 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806Ab2JBRZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 13:25:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q92HJajp001601
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2012 19:19:36 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TJ6EB-0002vp-Ls; Tue, 02 Oct 2012 19:25:51 +0200
In-Reply-To: <7v8vboaiy2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 02 Oct 2012 10:21:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Oct 2012 19:19:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q92HJajp001601
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349803177.4741@7isMssIYyLJvD3109j9J9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206825>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> David Glasser wrote:
>>>> Thanks Rankumar! There's also the reference in the "git push origin"
>>>> example and the "This is the default operation mode if no explicit
>>>> refspec is found".
>>>
>>> Sorry;  here's a revised patch.
>>
>> Sounds good, thanks (resend and Cc Junio if needed).
>
> That's an Ack?

Yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
