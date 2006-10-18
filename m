From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 08:44:49 +0200
Message-ID: <vpqlknem8bi.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
	<vpqbqob5euu.fsf@ecrins.imag.fr> <20061018011147.GN20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 18 08:46:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga5CG-0002Fe-KB
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 08:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWJRGqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 02:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWJRGqd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 02:46:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:55793 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1751439AbWJRGqc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 02:46:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9I6inTj009540
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Oct 2006 08:44:49 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ga5AX-0007OH-EZ; Wed, 18 Oct 2006 08:44:49 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1Ga5AX-0004uz-Be; Wed, 18 Oct 2006 08:44:49 +0200
To: bazaar-ng@lists.canonical.com, git@vger.kernel.org
In-Reply-To: <20061018011147.GN20017@pasky.or.cz> (Petr Baudis's message of "Wed\, 18 Oct 2006 03\:11\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Wed, 18 Oct 2006 08:44:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29196>

Petr Baudis <pasky@suse.cz> writes:

> The origin branch is considered readonly (though Git does
> not enforce it) and only mirrors the branch in the remote repository.

By curiosity, what happens if you accidentally commit to it?

-- 
Matthieu
