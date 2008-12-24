From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Git with Hudson
Date: Wed, 24 Dec 2008 15:04:11 -0600
Organization: Exigence
Message-ID: <20081224150411.8ef6a2ff.stephen@exigencecorp.com>
References: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
	<20081218160734.b1992eb8.stephen@exigencecorp.com>
	<c115fd3c0812181758m5fe4af95s860181d25f1992ee@mail.gmail.com>
	<20081222210018.f21d9e07.stephen@exigencecorp.com>
	<1230152365.14882.48.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tim Visher <tim.visher@gmail.com>,
	Indy Nagpal <indy@strakersoftware.com>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 22:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFav9-0005QE-7A
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 22:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbYLXVEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 16:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbYLXVEK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 16:04:10 -0500
Received: from smtp192.sat.emailsrvr.com ([66.216.121.192]:35292 "EHLO
	smtp192.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYLXVEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 16:04:10 -0500
Received: from relay19.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay19.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 888D11C17BD;
	Wed, 24 Dec 2008 16:04:09 -0500 (EST)
Received: by relay19.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id E7EFC1C1696;
	Wed, 24 Dec 2008 16:04:08 -0500 (EST)
In-Reply-To: <1230152365.14882.48.camel@starfruit>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103864>


> > Here's the "git2" Hudson plugin that worked well for us:
> > 
> > http://github.com/stephenh/hudson-git2
> > 
> > There is a git.hpi file checked into the target directory so that you
> > don't have to build it yourself.
> 
> I decided that I'd check this out, as the existing Git plugin chokes on
> our git-rev-list(1) on our enormous Git repository.
> 
> Correct me if I'm wrong, but did you actually upload or check in the
> target/ directory? Your .markdown references target/git.hpi as well, but
> I can't seem to find it :-/

Ack, sorry, just added it.

- Stephen
