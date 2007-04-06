From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [ANNOUNCE] GIT 1.5.1
Date: Fri, 06 Apr 2007 09:24:43 +0200
Message-ID: <vpq8xd6ge2s.fsf@bauges.imag.fr>
References: <7v648c7bbn.fsf@assigned-by-dhcp.cox.net>
	<200704041038.36183.andyparkins@gmail.com>
	<7vwt0s5tsc.fsf@assigned-by-dhcp.cox.net>
	<vpq8xd8o0q6.fsf@olympe.imag.fr>
	<7vlkh6kqk6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 09:25:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZioq-00019m-9Q
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 09:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767541AbXDFHZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 03:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767536AbXDFHZI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 03:25:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:60355 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767542AbXDFHZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 03:25:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l367OhnV013095
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Apr 2007 09:24:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HZioN-0007Eg-QA; Fri, 06 Apr 2007 09:24:43 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HZioN-0004ko-Mz; Fri, 06 Apr 2007 09:24:43 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <7vlkh6kqk6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 05 Apr 2007 22\:41\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 06 Apr 2007 09:24:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43904>

Junio C Hamano <junkio@cox.net> writes:

> Soon after 1.5.0 was released, I think we said these two were
> not used in practice and declared them as deprecated.  So there
> is no "use this instead".

$ man git-resolve | grep -i 'use .* instead'
Reformatting git-resolve(1), please wait...
       DEPRECATED and will be removed in 1.5.1. Use git-merge instead.

;-)

-- 
Matthieu
