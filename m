From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: bash completion patch
Date: Wed, 05 Feb 2014 17:08:22 +0100
Message-ID: <vpqk3d9o83t.fsf@anie.imag.fr>
References: <CAHtLG6Qgxq84Eo__vaXw5RAmyRuPnK-pt6n36+cjT8nVnRQN=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 17:08:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB51g-0007HS-0n
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 17:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbaBEQIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 11:08:31 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41689 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbaBEQIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 11:08:31 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s15G8LID014617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Feb 2014 17:08:21 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s15G8M9c021667;
	Wed, 5 Feb 2014 17:08:22 +0100
In-Reply-To: <CAHtLG6Qgxq84Eo__vaXw5RAmyRuPnK-pt6n36+cjT8nVnRQN=w@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Wed, 5 Feb 2014 23:13:33
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 05 Feb 2014 17:08:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s15G8LID014617
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1392221304.78182@LziLQe0PB13a1bwvIxvXWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241604>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> add --recurse-submodules

Thanks for the patch, but it cannot be included as-is.

Please, read Documentation/SubmittingPatches in Git's source tree. In
particular, the signed-off-by part. Also, don't use attachments to send
you patches (git send-email can help) and don't forget to Cc Junio if
you think your patch is ready for inclusion.

Thanks,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
