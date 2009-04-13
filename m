From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] http-push.c: DAV must support olny http and https scheme
Date: Mon, 13 Apr 2009 18:44:28 +0200
Message-ID: <vpq8wm4tser.fsf@bauges.imag.fr>
References: <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
	<1239562146-32133-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:51:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtPMm-0008IE-7y
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 18:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZDMQtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 12:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbZDMQtF
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 12:49:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:56497 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbZDMQtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 12:49:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3DGiaVt010907
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 Apr 2009 18:44:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LtPGm-0004fo-AY; Mon, 13 Apr 2009 18:44:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LtPGm-0003x0-61; Mon, 13 Apr 2009 18:44:28 +0200
In-Reply-To: <1239562146-32133-1-git-send-email-catap@catap.ru> (Kirill A. Korinskiy's message of "Sun\, 12 Apr 2009 22\:49\:06 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 13 Apr 2009 18:44:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116451>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> Subject: [PATCH] http-push.c: DAV must support olny http and https scheme
                                                  ^^

s/olny/only/ if it's not too late.

-- 
Matthieu
