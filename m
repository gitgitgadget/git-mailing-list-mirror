From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 11:12:24 -0500
Message-ID: <499D84E8.1020505@xiplink.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <FEE581A3-C858-45CF-B545-8F7187FCCE40@ai.rug.nl> <7v63j6oi0d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 17:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaBXL-0006ES-Lx
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 17:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbZBSQMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 11:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbZBSQMc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 11:12:32 -0500
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:59202 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbZBSQMb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 11:12:31 -0500
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 84D057BC4DD;
	Thu, 19 Feb 2009 11:12:30 -0500 (EST)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 53A197BC367;
	Thu, 19 Feb 2009 11:12:30 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7v63j6oi0d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110713>

Junio C Hamano wrote:
> 
>> I'd prefer something a bit less arbitrary, like using the tracked head
>> for a tracking branch.
> 
> I'd say that might be a very sane default for users or "branch --track"
> and/or "pull --rebase", both for i-rebase and rebase.

That's how I work, but even if that were the default I think I'd always specify the tracked branch head anyway.  It's good to always be specific with a powerful command like rebase.

		M.
