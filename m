From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Newbie:  Restore messed up code from local or remote repository
Date: Fri, 12 Nov 2010 17:57:09 +0100
Message-ID: <vpqzkte1nve.fsf@bauges.imag.fr>
References: <1289550163511-5731540.post@n2.nabble.com>
	<20101112124621.GF30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gzoller <gzoller@hotmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Nov 12 17:57:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGwwM-0003Qy-0G
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 17:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739Ab0KLQ5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 11:57:20 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57434 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932722Ab0KLQ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 11:57:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oACGoBVD006063
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 12 Nov 2010 17:50:12 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PGww2-0006xQ-BY; Fri, 12 Nov 2010 17:57:10 +0100
In-Reply-To: <20101112124621.GF30870@efreet.light.src> (Jan Hudec's message of "Fri\, 12 Nov 2010 13\:46\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 12 Nov 2010 17:50:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oACGoBVD006063
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1290185416.6444@Ve0pbwfkQrlbHeYOACLdEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161352>

Jan Hudec <bulb@ucw.cz> writes:

>> git checkout
>
> I don't think it does anything without argument. With argument '.' this
> restores working tree to the state in index (stage). So if you have that
> screwed up too, it won't be enough.

Actually, the output of "git status" will give you the right command
here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
