From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH v2 RFC] rebase-i-p: squashing and limiting todo
Date: Wed, 8 Oct 2008 02:15:46 -0500
Organization: Exigence
Message-ID: <20081008021546.c553289f.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTI4-0008TB-8u
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYJHHPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbYJHHPt
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:15:49 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:44177 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbYJHHPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:15:48 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 4FD262535B0;
	Wed,  8 Oct 2008 03:15:48 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id DF4AC2535A6;
	Wed,  8 Oct 2008 03:15:47 -0400 (EDT)
In-Reply-To: <cover.1223445353.git.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97781>


> This is v2 of my attempt at keeping commits with
> no-parents-being-rewritten off the rebase-i-p todo list. 

I forgot to mention, this series almost certainly conflicts with pu's
sh/maint-rebase3. Given that pu is not next, I think I did the right
thing by keeping this series separate, but I can merge them into one
series if that is preferable.

Thanks,
Stephen
