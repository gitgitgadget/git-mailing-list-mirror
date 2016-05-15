From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSOC Update] Week 2
Date: Sun, 15 May 2016 20:01:01 +0200
Message-ID: <vpqr3d32obm.fsf@anie.imag.fr>
References: <1462706822-5189-1-git-send-email-pranit.bauva@gmail.com>
	<1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	andrew.ardill@gmail.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 20:02:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b20MU-00029u-Ry
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 20:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbcEOSBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 14:01:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58997 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbcEOSBK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 14:01:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4FI0x0p003012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 15 May 2016 20:00:59 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4FI11Uq028907;
	Sun, 15 May 2016 20:01:01 +0200
In-Reply-To: <1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
	(Pranit Bauva's message of "Sun, 15 May 2016 23:15:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 15 May 2016 20:01:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4FI0x0p003012
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1463940062.98027@YhXMgVcIlV8Tdqpvtwyxfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294673>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> ================================= SUMMARY ==================================
> My micro project on adding config variable to git-commit for verbose options
> is going to be merged with the master branch soon and will be available for
> git 2.8.3 .

Nit: being merged to master doesn't mean you'll be in the next minor
release, but in the next _major_ one. 2.8.3 will only contain bugfixes
compared to 2.8.2.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
