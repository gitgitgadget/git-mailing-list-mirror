From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 12 Feb 2016 10:11:20 +0100
Message-ID: <vpqio1ucmyv.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<ED514A90-08AB-4EBC-BA17-ABAA06FE64FE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU9lV-0004cW-79
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 10:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbcBLJLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 04:11:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49956 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbcBLJLg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 04:11:36 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1C9BJeV018373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 12 Feb 2016 10:11:19 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1C9BKvL018607;
	Fri, 12 Feb 2016 10:11:20 +0100
In-Reply-To: <ED514A90-08AB-4EBC-BA17-ABAA06FE64FE@gmail.com> (Lars
	Schneider's message of "Fri, 12 Feb 2016 09:29:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 12 Feb 2016 10:11:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1C9BJeV018373
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1455873084.01195@2yY6IydDa3in0Dz4f3V/Yg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286041>

Lars Schneider <larsxschneider@gmail.com> writes:

> I don't know what level of Git development knowledge and what amount of time
> is necessary but I would be available as junior co-mentor :-)

AFAICT, you don't have much experience with Git's codebase itself (if I
don't count git-p4 as "Git itself"), but you've already been involved in
typical reviewing cycles (just the discussions on Travis-CI were a good
example), and that is something at least as important as knowing the
codebase well. It's up to you to decide whether you feel experienced
enough, but I think you are welcome as a co-mentor!

As a mentor, to me, the most important things are:

* Give advice on how to interact with the Git community. Students can be
  shy, and then repeating "you should post more to the mailing-list" can
  be useful. They sometimes make mistakes, and explaining off-list
  "there's nothing wrong with what you did, but the custom here is
  to ..." can help.

* Give advice on how to get useful code merged. My usual advice is:
  "don't be too ambitious", which translates to "git this part done,
  reviewed and possibly merged, you'll work on the bells and whistles
  later".

* Avoid overloading the list with reviews. Getting your own GSoC
  tee-shirt and letting the list do the work is unfair ;-). Off-list
  reviews are good to eliminate straightforwards issues, and then
  mentors should actively participate to the on-list review. That is
  probably what takes most time.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
