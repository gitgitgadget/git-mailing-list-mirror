From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 03 Oct 2012 09:54:40 +0200
Message-ID: <vpqhaqc6ldr.fsf@grenoble-inp.fr>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
	<CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
	<CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
	<CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com>
	<7vbogk90zk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 09:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJJnU-0007Fo-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 09:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab2JCHyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 03:54:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60520 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891Ab2JCHyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 03:54:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q937nCri017451
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2012 09:49:12 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TJJmz-0004pl-9l; Wed, 03 Oct 2012 09:54:41 +0200
In-Reply-To: <7vbogk90zk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 02 Oct 2012 11:34:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Oct 2012 09:49:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q937nCri017451
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349855357.11256@Rh3wwOXLivAtrcRERcd70A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206866>

Junio C Hamano <gitster@pobox.com> writes:

> I'll queue this instead.  Thanks.

Even better, perfect!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
