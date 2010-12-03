From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: path/to/some/file: needs update
Date: Fri, 03 Dec 2010 19:58:55 +0100
Message-ID: <vpqk4jq3cpc.fsf@bauges.imag.fr>
References: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 19:59:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POaqW-0005lG-6N
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 19:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab0LCS66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 13:58:58 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55073 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab0LCS66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 13:58:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oB3IgNsH011650
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 Dec 2010 19:42:23 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1POaqN-0006m1-G4; Fri, 03 Dec 2010 19:58:55 +0100
In-Reply-To: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com> (Patrick Doyle's message of "Fri\, 3 Dec 2010 13\:34\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Dec 2010 19:42:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oB3IgNsH011650
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1292006544.10249@Sq0y4zahRp1i5QR8f7IWSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162825>

Patrick Doyle <wpdster@gmail.com> writes:

> path/to/some/file: needs update.
>
> Then things got worse... one of the messages said:
>
> error: Entry 'path/to/some/binaryfile' not uptodate.  Cannot merge

Which commands triggered these messages? Which version of Git?

AFAICT, these messages never appear anymore in normal (porcelain) use
in recent Gits.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
