From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 15:42:18 +0200
Message-ID: <vpqlkc34ret.fsf@bauges.imag.fr>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 15:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INqU9-0001iN-FZ
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 15:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbXHVNm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 09:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756571AbXHVNm5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 09:42:57 -0400
Received: from imag.imag.fr ([129.88.30.1]:54343 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825AbXHVNm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 09:42:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7MDgIdH016570
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 15:42:19 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1INqTS-00057A-Oo; Wed, 22 Aug 2007 15:42:18 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1INqTS-0002Zt-MK; Wed, 22 Aug 2007 15:42:18 +0200
In-Reply-To: <86absjenc3.fsf@lola.quinscape.zz> (David Kastrup's message of "Wed\, 22 Aug 2007 15\:00\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 22 Aug 2007 15:42:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56379>

David Kastrup <dak@gnu.org> writes:

> Could you be so kind as to give a one-sentence summary what the
> benefits over using a shell script would be?  I think this work has
> started before I joined the list, and I'd be interested in the
> motivation for it.  In general, I find shell scripts more pleasant for
> hacking on than C code, and there is no long-term plan to replace all
> of them, is there?

That's a Google SoC project :

http://git.or.cz/gitwiki/SoC2007Projects?highlight=%28soc%29#head-2b49ddde32756b52fde3b9d9ab01e1bff6aa687c

-- 
Matthieu
