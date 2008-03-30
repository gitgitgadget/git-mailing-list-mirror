From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add new git-graph command
Date: Sun, 30 Mar 2008 22:44:29 +0200
Message-ID: <vpqiqz4vt5e.fsf@bauges.imag.fr>
References: <20080330195840.GA8695@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 22:45:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg4P9-0007yH-SL
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 22:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbYC3Uoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYC3Uop
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 16:44:45 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:46118 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbYC3Uop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 16:44:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m2UKiTGA025197;
	Sun, 30 Mar 2008 22:44:30 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Jg4OD-0001br-Ty; Sun, 30 Mar 2008 22:44:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Jg4OD-0000xf-QZ; Sun, 30 Mar 2008 22:44:29 +0200
In-Reply-To: <20080330195840.GA8695@adamsimpkins.net> (Adam Simpkins's message of "Sun\, 30 Mar 2008 12\:58\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Sun, 30 Mar 2008 22:44:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78514>

Adam Simpkins <adam@adamsimpkins.net> writes:

> This is a first pass at a command to print a text-based graph of the commit
> history.  It is similar to the history graph shown by gitk, but doesn't
> require a windowing system.

Did you look at git-forest too?

http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-ed34e1966c28f24d459c5ad30a21457baa9bed23

-- 
Matthieu
