From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Thu, 21 Nov 2013 09:36:37 +0100
Message-ID: <87txf6jgmi.fsf@linux-k42r.v.cablecom.net>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Straub <bs@github.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Christian Couder <christian.couder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Thomas Gumm
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 09:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjPkv-0003Mi-NI
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 09:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab3KUIgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 03:36:53 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:46814 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab3KUIgw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 03:36:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 214EC4D656F;
	Thu, 21 Nov 2013 09:36:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Fg6YgXLu_JCF; Thu, 21 Nov 2013 09:36:39 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D4E714D6414;
	Thu, 21 Nov 2013 09:36:37 +0100 (CET)
In-Reply-To: <8761stx04i.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Sat, 19 Oct 2013 08:09:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238113>

Thomas Rast <tr@thomasrast.ch> writes:

> * Does libgit2 want to remain under the Git umbrella, or participate
>   on its own?
>
> * Figure out the wiki situation.  In previous years the project
>   proposals and other important information were hosted at k.org [5] and
>   github wikis [6].  Other options were floated, such as an official
>   wiki hosted by github.  (This is somewhat of a contentious issue that
>   spans beyond GSoC.)
>
> * Find an org admin and backup.  In previous years Shawn and Peff did
>   this.  Would you do it again?

Any opinions on these points?

I would actually favor a move to a wiki of the style that Peff proposed,
hosted by github and backed by git with either a very mild ACL or none
("bots don't know git push").  k.org wiki had a grand total of three
edits in the last 30 days (plus some bot edits for user creation).

And of course without an org admin we don't really need to go any
further...



> [5]  https://git.wiki.kernel.org/index.php/SoC2011Projects
>      similarly for previous years
> [6]  https://github.com/peff/git/wiki/SoC-2012-Ideas
>      https://github.com/trast/git/wiki/SoC-2013-Ideas


-- 
Thomas Rast
tr@thomasrast.ch
