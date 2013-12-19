From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: prevent gitk collapsing tree view when viewing a different commit?
Date: Thu, 19 Dec 2013 13:57:43 -0500
Message-ID: <52B341A7.8050803@xiplink.com>
References: <20131219151507.GC23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Adam Spiers <git@adamspiers.org>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 19:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtimd-0001VU-Va
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 19:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab3LSS5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 13:57:15 -0500
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:43916 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab3LSS5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 13:57:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3C9211980BD;
	Thu, 19 Dec 2013 13:57:14 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E031419814A;
	Thu, 19 Dec 2013 13:57:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131219151507.GC23496@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239531>

On 13-12-19 10:15 AM, Adam Spiers wrote:
> Hi all,
> 
> If I launch gitk, switch the lower right pane from Patch view mode to
> Tree view, expand a few directories, and then changing to viewing a
> different commit, the tree automatically collapses again.  This is
> really annoying when trying to view changes to the tree structure over
> time; is there any way to stop it, or would it be an easy tweak to the
> code for someone familiar with it?  I had a look at the code but could
> hardly understand any of it :-/

What I would really like is that if I have a file selected in Patch view,
then that file is displayed when I switch to Tree view, and vice-versa.

Unfortunately such a change is beyond my Tcl skills.

		M.
