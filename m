From: sother <sotherlistas@gmail.com>
Subject: Re: git-svn bug: Could not unmemoize function `lookup_svn_merge'
 ...
Date: Thu, 18 Aug 2011 06:23:15 -0700 (PDT)
Message-ID: <1313673795755-6699369.post@n2.nabble.com>
References: <AANLkTi=14DKGzotpZT66dG93uWHhpCa526C8F7Zk_REa@mail.gmail.com> <AANLkTikW2jgPfO_tsdzuD6pZJAJMQPezMr7ZQvgWtkFY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 15:23:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu2Z7-0002QG-B6
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 15:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652Ab1HRNXQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 09:23:16 -0400
Received: from sam.nabble.com ([216.139.236.26]:49807 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab1HRNXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 09:23:16 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <sotherlistas@gmail.com>)
	id 1Qu2Z1-0003ps-Og
	for git@vger.kernel.org; Thu, 18 Aug 2011 06:23:15 -0700
In-Reply-To: <AANLkTikW2jgPfO_tsdzuD6pZJAJMQPezMr7ZQvgWtkFY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179595>

I've got the same problem using Git for Windows version 1.7.4. I=C2=B4v=
e
downgraded to version 1.6.1 and it worked.

--
View this message in context: http://git.661346.n2.nabble.com/git-svn-b=
ug-Could-not-unmemoize-function-lookup-svn-merge-tp5871159p6699369.html
Sent from the git mailing list archive at Nabble.com.
