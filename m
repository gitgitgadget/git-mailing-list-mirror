From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Tue, 03 Jul 2007 12:37:40 +0200
Message-ID: <vpqoditkc23.fsf@bauges.imag.fr>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<vpq7ipittl2.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707022205210.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 12:38:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5fm3-0008CE-B1
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 12:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbXGCKiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 06:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756647AbXGCKiU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 06:38:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:49257 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504AbXGCKiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 06:38:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l63AbecY006060
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 12:37:40 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I5flM-0002fW-CY; Tue, 03 Jul 2007 12:37:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I5flM-0002pA-A5; Tue, 03 Jul 2007 12:37:40 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>,  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0707022205210.4071@racer.site> (Johannes Schindelin's message of "Mon\, 2 Jul 2007 22\:05\:35 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 03 Jul 2007 12:37:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51472>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What's so wrong with our man pages? You know, there have been man hours 
> invested in them, and they are exclusively meant for consumption by people 
> who do not know about the usage of the commands...

What's wrong is just that I shouldn't have to read a man page to avoid
data-loss. I should have to read them to do non-trivial things, for
sure.

Useability is not just about documenting surprising behaviors, it's
really about avoiding them.

-- 
Matthieu
