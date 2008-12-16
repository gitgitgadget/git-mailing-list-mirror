From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Tue, 16 Dec 2008 01:22:49 +0100
Message-ID: <4946F4D9.8050803@gmx.ch>
References: <878wqhxaex.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: jidanni@jidanni.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 01:24:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCNjU-00075R-K9
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 01:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbYLPAWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 19:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbYLPAWw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 19:22:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:45097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754622AbYLPAWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 19:22:52 -0500
Received: (qmail invoked by alias); 16 Dec 2008 00:22:49 -0000
Received: from 36-167.3-85.cust.bluewin.ch (EHLO [192.168.123.204]) [85.3.167.36]
  by mail.gmx.net (mp064) with SMTP; 16 Dec 2008 01:22:49 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/zT2IqTKHzn/V5UZ0eaarmuYdMoqqPhV0ZsSc692
	CWCIhJAYGIeCNy
User-Agent: Thunderbird 2.0.0.18 (X11/20081123)
In-Reply-To: <878wqhxaex.fsf@jidanni.org>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103221>

Hi!

jidanni@jidanni.org wrote:
> The git-clone manpage should mention how to determine how much disk
> space will be used.
> [...]
> And don't tell us to just figure it out from the progress messages
> after the download begins, and hit ^C if we don't like it.

Maybe that's a dumb answer, but... why not?  This works pretty
well for me.

> Nope, nowhere does it directly say "You Holmes, are in for 27
> Megabytes (on your piddly modem)". There obviously is math involved to
> figure it out... math!

So maybe what you really want is an ETA display during the cloning
process?  Sounds like a good idea to me.

jlh
