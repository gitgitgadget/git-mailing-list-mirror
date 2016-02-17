From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 19:58:04 +0100
Message-ID: <vpqh9h7f9kz.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:58:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7Ir-00057u-PG
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161803AbcBQS6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:58:17 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39921 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161037AbcBQS6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:58:15 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1HIw1Mk006122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 17 Feb 2016 19:58:01 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1HIw4qs003176;
	Wed, 17 Feb 2016 19:58:04 +0100
In-Reply-To: <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com> (Lars
	Schneider's message of "Wed, 17 Feb 2016 19:32:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 17 Feb 2016 19:58:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1HIw1Mk006122
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456340283.13619@GLIQqmA08u/IeZ8N7Dhy3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286533>

Lars Schneider <larsxschneider@gmail.com> writes:

> Coincidentally I started working on similar thing already (1) and I have
> lots of ideas around it.

I guess it's time to start sharing these ideas then ;-).

I think there's a lot to do. If we want to push this idea as a GSoC
project, we need:

* A rough plan. We can't expect students to read a vague text like
  "let's make Git safer" and write a real proposal out of it.

* A way to start this rough plan incrementally (i.e. first step should
  be easy and mergeable without waiting for next steps).

Feel free to start writting an idea for
http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
ideas before Friday. We can polish them later if needed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
