From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Fwd: [BUG] dos2unix converts french accents to NULL char
Date: Wed, 04 Feb 2015 18:07:41 +0100
Message-ID: <vpqr3u561wi.fsf@anie.imag.fr>
References: <CAD7Fce8vwrAZL-gh9a7530Tr=z=fpmqfOAdSMH7u4Jc_Odespg@mail.gmail.com>
	<CAD7Fce_60W=LvdhyW-fwEqzWnerC6WwV3Sw8VLct08LqDdrTJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Louis BAYLE <lbayle.work@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:08:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ3Qp-00006A-EI
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 18:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349AbbBDRHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 12:07:53 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48706 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161289AbbBDRHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 12:07:50 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t14H7dfI025208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Feb 2015 18:07:39 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t14H7fEm023157;
	Wed, 4 Feb 2015 18:07:41 +0100
In-Reply-To: <CAD7Fce_60W=LvdhyW-fwEqzWnerC6WwV3Sw8VLct08LqDdrTJg@mail.gmail.com>
	(Louis BAYLE's message of "Wed, 4 Feb 2015 17:00:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Feb 2015 18:07:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t14H7dfI025208
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1423674464.48192@6zKQbWmsqvfhKzlHBS+/fA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263353>

Louis BAYLE <lbayle.work@gmail.com> writes:

> when converting a text file with unix2dos.exe or dos2unix.exe (via git
> bash),

Neither of these executables are part of Git. If you ask the question, I
guess unix2dos.exe and dos2unix.exe are distributed as part of the Git
for Windows distribution (which includes Git plus some programs from
MinGW). You have better chance of getting an answer on the mailing list
of this distribution:

http://groups.google.com/group/msysgit

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
