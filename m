From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Fri, 30 Jul 2010 17:24:25 +0200
Message-ID: <vpqd3u53sd2.fsf@bauges.imag.fr>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 17:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OerRs-0004iq-3l
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 17:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab0G3PYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 11:24:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49985 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab0G3PYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 11:24:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6UFMY59031147
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 17:22:34 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OerRh-00068b-Sa; Fri, 30 Jul 2010 17:24:25 +0200
In-Reply-To: <4C52E6E1.20101@xiplink.com> (Marc Branchaud's message of "Fri\, 30 Jul 2010 10\:51\:13 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 30 Jul 2010 17:22:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6UFMY59031147
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281108156.60088@G2ioH/I4Xi3vjmziySxMTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152248>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> The name of the command may be subject to discussions. I've chosen
>> "run", but maybe "shell" would be OK too. In both cases, it doesn't
>> allow the one-letter version since both "r" and "s" are already used.
>
> "exec" with one-letter "x"?

Thanks, that sounds good, yes. Any other thought?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
