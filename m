From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: What's cooking in git.git (Nov 2013, #02; Wed, 6)
Date: Thu, 07 Nov 2013 10:39:37 -0500
Message-ID: <527BB439.8010606@xiplink.com>
References: <xmqq7gcl6pwi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: coder5000@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 07 16:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeRg8-0001LA-Or
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 16:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab3KGPjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 10:39:23 -0500
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:38212 "EHLO
	smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752368Ab3KGPjW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Nov 2013 10:39:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 73CAB1480E5;
	Thu,  7 Nov 2013 10:39:21 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp1.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 3E2E01480E6;
	Thu,  7 Nov 2013 10:39:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqq7gcl6pwi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237412>

On 13-11-06 07:01 PM, Junio C Hamano wrote:
> 
> There is a proposed rewording of advice message from "git push"
> patch, which is tentatively queued near the tip of 'pu' for now; it
> would be nice to get a few more sets of eyeballs.  I am not sure if
> we should merge it before the 1.8.5 final, yet (we have i18n to
> worry about, among other things).

I was all set to comment (having been asked so nicely!), but the patch in pu
looks like the last "v3" version, of which there was some discussion[1] that
I believe should result in a v4.  I prefer to hold off commenting until the
next update.

[1] http://thread.gmane.org/gmane.comp.version-control.git/235713/focus=237384

		M.
