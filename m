From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Git with Hudson
Date: Mon, 22 Dec 2008 21:00:18 -0600
Organization: Exigence
Message-ID: <20081222210018.f21d9e07.stephen@exigencecorp.com>
References: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
	<20081218160734.b1992eb8.stephen@exigencecorp.com>
	<c115fd3c0812181758m5fe4af95s860181d25f1992ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Indy Nagpal" <indy@strakersoftware.com>, git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 04:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LExze-0005HX-D9
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 04:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYLWDaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 22:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbYLWDaU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 22:30:20 -0500
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:48974 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYLWDaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 22:30:19 -0500
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id F1488202821;
	Mon, 22 Dec 2008 22:00:18 -0500 (EST)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 5BCF1202415;
	Mon, 22 Dec 2008 22:00:18 -0500 (EST)
In-Reply-To: <c115fd3c0812181758m5fe4af95s860181d25f1992ee@mail.gmail.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103800>


> I'm interested!  Please publish away!

Here's the "git2" Hudson plugin that worked well for us:

http://github.com/stephenh/hudson-git2

There is a git.hpi file checked into the target directory so that you
don't have to build it yourself.

- Stephen
