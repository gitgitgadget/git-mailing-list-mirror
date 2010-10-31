From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 0/2] Documentation: kicking the "reset --hard" habit
Date: Sun, 31 Oct 2010 15:04:14 +0100
Message-ID: <vpqaalujw69.fsf@bauges.imag.fr>
References: <20101029083516.GA26290@burratino>
	<vpqzktwv3yx.fsf@bauges.imag.fr>
	<7vd3qr3tm8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 15:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCYWY-0007nG-Cf
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 15:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab0JaOEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 10:04:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52667 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004Ab0JaOEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 10:04:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9VDnMLW030754
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 31 Oct 2010 14:49:22 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PCYW7-0002nm-DU; Sun, 31 Oct 2010 15:04:15 +0100
In-Reply-To: <7vd3qr3tm8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 30 Oct 2010 20\:53\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 31 Oct 2010 14:49:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9VDnMLW030754
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289137766.44178@e8XCdyAUJt0617TO4+/m+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160441>

Junio C Hamano <gitster@pobox.com> writes:

> What is the oldest version of git that is shipped with _current_ distros,
> by the way?

Debian stable has 1.5.6.5. Since there should be a Debian release
within the next few months, that should be an upper bound on how old a
package can get in a release (well, unless for RedHat users maybe).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
