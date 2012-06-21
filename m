From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: start warning upcoming default change for push.default
Date: Thu, 21 Jun 2012 19:08:29 +0200
Message-ID: <vpq62aksicy.fsf@bauges.imag.fr>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
	<1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vehp9x3yz.fsf@alter.siamese.dyndns.org>
	<vpqpq8t96zw.fsf@bauges.imag.fr>
	<7va9zxvkyp.fsf@alter.siamese.dyndns.org>
	<7v62alvk2e.fsf@alter.siamese.dyndns.org>
	<vpqd34su0io.fsf@bauges.imag.fr>
	<7vobocsipo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:09:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shksh-0003o2-9S
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 19:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759915Ab2FURJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 13:09:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52061 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab2FURJO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 13:09:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5LH85Jm031449
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 19:08:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Shkru-0000Kk-9h; Thu, 21 Jun 2012 19:08:30 +0200
In-Reply-To: <7vobocsipo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 21 Jun 2012 10:00:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 21 Jun 2012 19:08:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5LH85Jm031449
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340903290.41676@RgMY6YM9dcEVBUb0c8lPuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200408>

Junio C Hamano <gitster@pobox.com> writes:

> Re-read the part you omitted with [...].  Doesn't it say something
> about "only available"?

It does, but it seems you're trying hard to avoid telling the user "you
should use 'current'", where 'current' is the only reasonable option for
this user. I still don't understand what problem you're trying to solve.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
