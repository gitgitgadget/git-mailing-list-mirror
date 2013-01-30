From: Max Horn <max@quendi.de>
Subject: Anybody know a website with up-to-date git documentation?
Date: Wed, 30 Jan 2013 12:46:47 +0100
Message-ID: <D6EAC791-63E2-4B0E-92AA-676112039BD9@quendi.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 12:47:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0W8H-0003eM-3q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 12:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab3A3Lqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 06:46:52 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53770 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754213Ab3A3Lqu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 06:46:50 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1U0W7r-0002il-NM; Wed, 30 Jan 2013 12:46:47 +0100
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1359546410;6898cd81;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215010>

Hi,

does anybody know a website where one can view that latest git documentation? Here, "latest" means "latest release" (though being also able to access it for "next" would of course be a nice bonus, likewise for older versions). While I do have those docs on my local machine, I would like to access them online, too (e.g. easier to pointer people at this, I can access it from other machines, etc.).


My problem is that all sites I know of are outdated, and thus don't show recent improvements. Also, for many it is hard to determine for which version of git they carry documentation. Here are the contenders I know, and the problems they have:


* The closest I know is http://git-scm.com/ -- they fit the bill almost perfectly. Except that sadly, some pages that are crucial for me are permanently stuck at outdated versions, like http://git-scm.com/docs/git-remote-helpers which is stuck at 1.7.12.3. I tried contacting them about this for two months now, but to no avail (multiple bug reports, direct emails, etc. all went w/o reaction). Of course time and resources are limited, so I fully understand and respect that the people behind it (Scott Chacon in particular, who did an awesome job creating that site in the first place) have other priorities.

* http://www.kernel.org/pub/software/scm/git/docs/ was last updated in May 2012. No hints on who maintains this and how to contact them. Attempts to contact kernel.org webadmins to find out more were not answered either :-(. Anybody know more?

* http://schacon.github.com/git/git-remote-helpers.html was lasted updated in May 2011. I assume git-scm.com is supposed to replace it, though, as Scott Chacon made git-scm.com. (In that case, a redirect to git-scm.com might be nice *g* but of course is extra work) 

* http://www.manpagez.com/man/1/git/ and http://man.he.net/man1/git at least document on each page from which git version it is taken. Unfortunately, both are stuck at the 1.7.x series.

* http://linux.die.net/man/1/git does not indicate the git version, but it seems to be a 1.7.x, too


Anybody know an up-to-date alternative? Or do I have to setup my own? :-(.


Cheers,
Max