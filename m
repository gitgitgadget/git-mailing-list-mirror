From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 16:27:07 +0200
Message-ID: <vpq7iysjuis.fsf@ecrins.imag.fr>
References: <200610180246.18758.jnareb@gmail.com>
	<20061020141222.GA17497@coredump.intra.peff.net>
	<453A5F6D.7020306@utoronto.ca> <200610212020.08539.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 16:28:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbeJ5-000581-1A
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 16:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWJVO2D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 10:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWJVO2D
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 10:28:03 -0400
Received: from imag.imag.fr ([129.88.30.1]:14499 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1750972AbWJVO2B (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 10:28:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9MER7IE013041
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Oct 2006 16:27:07 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GbeI7-0002lV-JJ; Sun, 22 Oct 2006 16:27:07 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GbeI7-0000cq-G3; Sun, 22 Oct 2006 16:27:07 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610212020.08539.jnareb@gmail.com> (Jakub Narebski's message of "Sat\, 21 Oct 2006 20\:20\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Sun, 22 Oct 2006 16:27:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29753>

Jakub Narebski <jnareb@gmail.com> writes:

> What about grandparent of commit (d8a60^^ or d8a60~2 in git),
> or choosing one of the parents in merge commit (d8a60^2 is second
> parent of a commit)? before:before:753 ?

Yes, "before:" can take any revision specifier, including
"before:something-else".

-- 
Matthieu
