From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: can pre-commit hook accept user input?
Date: Sat, 22 May 2010 14:11:15 +0200
Message-ID: <1274530138-sup-6441@nixos>
References: <ht7co7$d0s$1@dough.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 22 14:11:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFnY6-00041C-Es
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 14:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab0EVMLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 08:11:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:43099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754153Ab0EVMLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 08:11:19 -0400
Received: (qmail invoked by alias); 22 May 2010 12:11:16 -0000
Received: from pD9E0AA67.dip.t-dialin.net (EHLO mail.gmx.net) [217.224.170.103]
  by mail.gmx.net (mp011) with SMTP; 22 May 2010 14:11:16 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/N5cglE1bN6QSB61D3arzzv0SYGYdbJiooiWoir9
	NUBYVGT0EO4LDj
Received: by mail.gmx.net (sSMTP sendmail emulation); Sat, 22 May 2010 14:11:15 +0200
In-reply-to: <ht7co7$d0s$1@dough.gmane.org>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147521>

Excerpts from Neal Kreitzinger's message of Sat May 22 03:41:11 +0200 2010:
> Can the pre-commit hook accept user input?  I'm new to linux and bash 

Maybe try describing why you want to add this hook?
Which purpose does it have?
Maybe there is another way to get what you want.

There may be some ways using new ttys and such to be able to read from
stdin again. Maybe even use tools such as xmessage or gui inputs.

But this should be a personal hack only then - because I don't know
exactly those hooks are run. So tell more about the "why" and maybe
you'll get much feedback about the "how" to do it.

Marc Weber
