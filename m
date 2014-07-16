From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v1] rebase -p: Command line option --no-ff is ignored
Date: Wed, 16 Jul 2014 14:07:38 -0400
Message-ID: <53C6BF6A.8030105@xiplink.com>
References: <d8a1d5015e5562a706c1e8cf574d6011f1f1ac38.1404704884.git.bafain@gmail.com> <53C6A1CC.2000306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Tl1-0004jP-MR
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 20:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934862AbaGPSQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 14:16:43 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:52779 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025AbaGPSQk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 14:16:40 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2014 14:16:40 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp11.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3C323380168;
	Wed, 16 Jul 2014 14:07:32 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp11.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EEE7D3801EC;
	Wed, 16 Jul 2014 14:07:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C6A1CC.2000306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253682>

On 14-07-16 12:01 PM, Fabian Ruch wrote:
> Hi Marc,
> 
> I forgot to cc your mailbox when I posted this patch last week. Do you
> still remember whether there was a particular reason why
> pick_one_preserving_merges wasn't touched by the commit b499549 ("Teach
> rebase the --no-ff option."), by any chance?

I think it was simply overlooked.  (Though it was very long ago and my brain
can barely keep track of what I did last week...)

		M.
