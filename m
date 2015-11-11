From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Apple Xcode Asserts Control Over Git - License Violation?
Date: Wed, 11 Nov 2015 15:44:36 +0100
Message-ID: <vpqvb98vbmz.fsf@anie.imag.fr>
References: <B28E3F82-E5BD-4B6A-A28D-CEA54774E8D9@skymion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: ARaybould <araybould@skymion.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 15:44:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwWdl-0007LK-H3
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 15:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbbKKOoq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2015 09:44:46 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42320 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbbKKOop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 09:44:45 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tABEiYen019138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 11 Nov 2015 15:44:34 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tABEialn020452;
	Wed, 11 Nov 2015 15:44:36 +0100
In-Reply-To: <B28E3F82-E5BD-4B6A-A28D-CEA54774E8D9@skymion.com>
	(araybould@skymion.com's message of "Wed, 11 Nov 2015 09:30:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Nov 2015 15:44:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tABEiYen019138
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1447857877.9708@J69zHG48h17n790rS+CnyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281167>

ARaybould <araybould@skymion.com> writes:

> I recently installed Xcode 7.1.1 on my Mac. While this was underway, =
I
> continued to work on an unrelated project, until I found I could not
> use git from the command-line. Instead, I got this message:
>
> Agreeing to the Xcode/iOS license requires admin privileges, please r=
e-run as root via sudo.
>
> Is Apple in violation of git=E2=80=99s license by imposing this restr=
iction?

AFAICT, no, see explanations here:

http://permalink.gmane.org/gmane.comp.version-control.git/254890

or search "apple git gpl license violation" in your favorite search
engine.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
