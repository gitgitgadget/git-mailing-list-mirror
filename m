From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Aug 2013, #07; Wed, 28)
Date: Thu, 29 Aug 2013 09:20:30 +0200
Message-ID: <vpqppsx0xq9.fsf@anie.imag.fr>
References: <xmqqtxi9761a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: stefanbeller@googlemail.com
X-From: git-owner@vger.kernel.org Thu Aug 29 09:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEwX4-0002M8-1r
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 09:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab3H2HUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 03:20:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36984 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761Ab3H2HUh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 03:20:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7T7KU88003831
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 09:20:30 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEwWs-0004TG-Ur; Thu, 29 Aug 2013 09:20:31 +0200
In-Reply-To: <xmqqtxi9761a.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 Aug 2013 16:24:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 09:20:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7T7KU88003831
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378365631.8454@9ItCs9hrL0JOUwxx8Hbfzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233241>

Junio C Hamano <gitster@pobox.com> writes:

> * sb/repack-in-c (2013-08-22) 3 commits
>  - repack: rewrite the shell script in C (squashing proposal)
>  - repack: retain the return value of pack-objects
>  - repack: rewrite the shell script in C

Just a ping to make sure the series is not forgotten. Stefan, I guess
it's time to send the squashed and hopefully final version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
