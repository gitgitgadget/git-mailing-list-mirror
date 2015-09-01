From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: GSoC 2015 is over
Date: Tue, 01 Sep 2015 18:55:04 +0200
Message-ID: <vpq8u8qw047.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:55:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWoqG-0005Fi-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 18:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbbIAQzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 12:55:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57580 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbbIAQzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 12:55:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t81Gt23X018867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 1 Sep 2015 18:55:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t81Gt4Jm010626;
	Tue, 1 Sep 2015 18:55:04 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Sep 2015 18:55:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t81Gt23X018867
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441731304.92954@HeOvbYVexXd5P2edr5pGkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276991>

Hi,

The Google Summer of Code 2015 is officially over. We had two students
(Paul and Karthik), and both of them passed. 100 % success :-).

I didn't follow closely Paul's work, but we now have C builtins for
"pull" and "am" (both in master) instead of shell scripts. Karthik
worked on the unification of "for-each-ref", "tag" and "branch". We
already have more options for "for-each-ref". tag and branch are being
ported to use the same library code as "for-each-ref" (2 patch series
under review).

I consider this GSoC as a great success and a pleasant experience.
Congratulation to Paul and Karthik, and a warm "thank you" to everybody
who contributed: administrators, mentors, reviewers, and obviously
Junio! (not to mention Google, who made all this possible)

Thanks all!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
