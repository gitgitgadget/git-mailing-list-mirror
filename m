From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] Script to install, delete and clear a MediaWiki
Date: Thu, 31 May 2012 09:19:27 +0200
Message-ID: <vpqtxywq0lc.fsf@bauges.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
	<1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 31 09:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZzfW-0007EL-6O
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 09:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab2EaHTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 03:19:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57293 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab2EaHTd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 03:19:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4V7B2ZH014990
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 09:11:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZzfM-0003Gy-S8; Thu, 31 May 2012 09:19:28 +0200
In-Reply-To: <1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	(Simon Cathebras's message of "Wed, 30 May 2012 19:04:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 May 2012 09:11:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V7B2ZH014990
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339053065.45342@x3AJfHd3jSQqBH0/1Cw+Jg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198869>

Simon Cathebras <simon.cathebras@ensimag.imag.fr> writes:

> install_wiki also defines a function cmd_reset

Why the "cmd_reset" name?

Wouldn't wiki_reset be both more descriptive and more consistent?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
