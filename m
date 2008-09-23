From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Tue, 23 Sep 2008 16:22:11 -0500
Organization: Exigence
Message-ID: <20080923162211.d4b15373.stephen@exigencecorp.com>
References: <48D95836.6040200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFMH-0001Hw-6W
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885AbYIWVW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbYIWVW0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:22:26 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:43074 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbYIWVWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:22:25 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id D18F05B05D6;
	Tue, 23 Sep 2008 17:22:23 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 1F5803B3A37;
	Tue, 23 Sep 2008 17:22:18 -0400 (EDT)
In-Reply-To: <48D95836.6040200@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96602>


> Stephen, I had to modify the tests a bit to get them to work with how
> I implemented the merge-preserving rebase, and also to remove a lot of
> the cruft that was previously in there. Hope you're ok with the
> attribution in the commit message.

No problem, it looks great.

This is awesome. Thanks for the insanely short turnaround. The
GIT_EDITOR=: hack is neat. I did not think it would be that simple.

- Stephen
