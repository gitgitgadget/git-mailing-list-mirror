From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: &&-chaining tester
Date: Thu, 08 Dec 2011 09:06:58 +0100
Message-ID: <vpqmxb37ahp.fsf@bauges.imag.fr>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
	<1323286611-4806-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 09:07:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZ0Z-0001VJ-Qq
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab1LHIHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:07:05 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53324 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab1LHIHE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:07:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id pB880sjh020611
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Dec 2011 09:00:54 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RYZ0M-0005Ff-D3; Thu, 08 Dec 2011 09:06:58 +0100
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 8 Dec 2011 01:06:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Dec 2011 09:00:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pB880sjh020611
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1323936055.85207@Xwhk3+omwvo6O/Ye2s379A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186535>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hm, involves a huge amount of janitorial work.  Anyway, thanks for
> pointing me in the right direction- here's a small start.

Patches 1-14 look good to me (with Jonathan's remarks). I didn't review
patch 15.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
