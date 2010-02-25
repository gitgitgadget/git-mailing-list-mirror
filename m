From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Fix gitmkdtemp: correct test for mktemp() return value
Date: Thu, 25 Feb 2010 19:05:46 +0100
Message-ID: <vpqzl2xdwcl.fsf@bauges.imag.fr>
References: <4B864A7B.9000500@flexerasoftware.com>
	<7veik99q4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Filippo Negroni <fnegroni@flexerasoftware.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nki7N-0003tx-Np
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 19:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204Ab0BYSHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 13:07:16 -0500
Received: from mx2.imag.fr ([129.88.30.17]:60772 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933195Ab0BYSHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 13:07:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o1PI3HLa016176
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 25 Feb 2010 19:03:17 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Nki5q-00007U-D3; Thu, 25 Feb 2010 19:05:46 +0100
In-Reply-To: <7veik99q4q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 25 Feb 2010 09\:33\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2010 19:03:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o1PI3HLa016176
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1267725799.19195@mfSzLqtjluqLPHLe9y4Tqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141060>

Junio C Hamano <gitster@pobox.com> writes:

> Next time please do not quote the mbox header lines (i.e. start your body
> with "In gitmkdtemp, the return value ...".

... or just use "git send-email", which does the trick for you.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
