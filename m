From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [ANNOUNCE] GIT 1.5.1
Date: Wed, 04 Apr 2007 13:09:05 +0200
Message-ID: <vpq8xd8o0q6.fsf@olympe.imag.fr>
References: <7v648c7bbn.fsf@assigned-by-dhcp.cox.net>
	<200704041038.36183.andyparkins@gmail.com>
	<7vwt0s5tsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 13:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ3Mr-0006qm-4h
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 13:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992834AbXDDLJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 07:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992841AbXDDLJQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 07:09:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:51662 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992834AbXDDLJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 07:09:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l34B96tY006804
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Apr 2007 13:09:06 +0200 (CEST)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HZ3MP-0007fx-UP; Wed, 04 Apr 2007 13:09:05 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HZ3MP-0004OV-Rm; Wed, 04 Apr 2007 13:09:05 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <7vwt0s5tsc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 04 Apr 2007 03\:16\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Apr 2007 13:09:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43727>

Junio C Hamano <junkio@cox.net> writes:

> Thanks -- that's very true.  I meant that they are loooong
> deprecated, and finally we removed them in this release.

In a perfect world, the release notes would mention the reason for the
removal (e.g. "use git foo-bar instead").

-- 
Matthieu
