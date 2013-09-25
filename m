From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Wed, 25 Sep 2013 09:04:22 +0200
Message-ID: <vpq1u4d1ix5.fsf@anie.imag.fr>
References: <1380051150-6863-1-git-send-email-benoit.person@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Benoit Person <benoit.person@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 09:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOj9E-0005or-PU
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 09:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267Ab3IYHE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 03:04:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59880 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab3IYHE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 03:04:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8P74Muo016267
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 09:04:22 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOj95-00036O-03; Wed, 25 Sep 2013 09:04:23 +0200
In-Reply-To: <1380051150-6863-1-git-send-email-benoit.person@gmail.com>
	(Benoit Person's message of "Tue, 24 Sep 2013 21:32:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Sep 2013 09:04:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8P74Muo016267
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380697464.98309@d5XPGYNep84Em4zoeDD0Og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235333>

Benoit Person <benoit.person@gmail.com> writes:

>  contrib/mw-to-git/git-remote-mediawiki.perl     | 14 ++++++++++++--
>  contrib/mw-to-git/t/t9365-continuing-queries.sh | 23 +++++++++++++++++++++++

This version sounds all right. Thanks a lot,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
