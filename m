From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 08 Mar 2007 18:19:06 +0100
Message-ID: <vpqejnz3b79.fsf@olympe.imag.fr>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 18:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMGu-0005Jn-Fg
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXCHRTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbXCHRTR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:19:17 -0500
Received: from imag.imag.fr ([129.88.30.1]:59849 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbXCHRTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:19:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l28HJ6Kg002174
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 8 Mar 2007 18:19:07 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HPMGg-000174-K0
	for git@vger.kernel.org; Thu, 08 Mar 2007 18:19:06 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HPMGg-0006sx-H9
	for git@vger.kernel.org; Thu, 08 Mar 2007 18:19:06 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Thu\, 8 Mar 2007 18\:10\:54 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 08 Mar 2007 18:19:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41760>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about something totally different: "git log --shortlog". I.e.

Then, I'd say just --short.

-- 
Matthieu
