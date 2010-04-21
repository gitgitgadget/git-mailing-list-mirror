From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 23:59:56 +0200
Message-ID: <vpqsk6omppf.fsf@bauges.imag.fr>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 00:00:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hxw-0004PW-5i
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 00:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab0DUWAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 18:00:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47947 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543Ab0DUWAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 18:00:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o3LLsevV032659
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Apr 2010 23:54:42 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O4hxc-0003gW-Db; Wed, 21 Apr 2010 23:59:56 +0200
In-Reply-To: <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com> (Aghiles's message of "Wed\, 21 Apr 2010 17\:55\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Apr 2010 23:54:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3LLsevV032659
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1272491684.8871@y7Ier/8rH12HVMlxVAa9IA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145467>

Aghiles <aghilesk@gmail.com> writes:

>> When you do this you're telling git "I want a new branch from where I
>> am right now". If you want to be able to pull in a similar way to how
>> master works, use the '--track' option.
>
> Actually, the '--track' option is exactly what I don't want ! :) It
> tells me:

Read the doc. It is what you want, but you mis-use it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
