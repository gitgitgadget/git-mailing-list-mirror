From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: About the "git merge" tee-shirt
Date: Mon, 13 Apr 2015 22:50:55 +0200
Message-ID: <vpqr3rnoiq8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 22:51:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhlK0-0007JV-MT
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 22:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbbDMUvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 16:51:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50600 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbbDMUvB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 16:51:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3DKoql8032275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Apr 2015 22:50:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3DKotQ1028019;
	Mon, 13 Apr 2015 22:50:55 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 13 Apr 2015 22:50:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3DKoql8032275
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1429563054.53552@evvmIHCL8RQt9qac1YCIhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267099>

Hi,

For those of you who weren't at the Git Merge conference last week, we
goot a tee-shirt with this drawing:

https://drive.google.com/file/d/1v9bfY0mI8Hi94m4SgqLccFnZ5L_OUlaJSA/view?usp=sharing

I have to say I love that tee-shirt. I already had tee-shirts that only
computer scientists could understand, now I have a tee-shirt that not
even every computer scientist can understand.

Now, I have a problem: I'm not sure I understand what the drawing
represents.

Initially, I thought the circles represented Git contributors, and links
represented people contributing to the same parts of the codebase. But
looking at the output of "shortlog -s", I can't find a correspondance
with the tee-shirt. My second guess is that they represent directories.
But even then, I can't find which of the tee-shirt's circles represents
which directory, and the count doesn't match.

Does anybody have a better explanation? Or is it just a random drawing
to say "Git is bigger than it used to be"?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
