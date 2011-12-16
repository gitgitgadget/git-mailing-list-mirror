From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: How to commit incomplete changes?
Date: Fri, 16 Dec 2011 13:58:12 +0100
Message-ID: <hbf.20111216ym10@bombur.uio.no>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
	<4EEA79E0.4070700@gmail.com>
	<7v8vmdl62s.fsf@alter.siamese.dyndns.org>
	<hbf.20111216xubv@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 13:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbXMk-0001aE-Nn
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 13:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759090Ab1LPM6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 07:58:19 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:49328 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758751Ab1LPM6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 07:58:17 -0500
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbXMe-0005lB-1W; Fri, 16 Dec 2011 13:58:16 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx4.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbXMd-0001mx-Mo; Fri, 16 Dec 2011 13:58:16 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id A5772E26; Fri, 16 Dec 2011 13:58:12 +0100 (CET)
In-Reply-To: <hbf.20111216xubv@bombur.uio.no>
X-Mailer: VM 7.19 under Emacs 23.1.1
X-UiO-Ratelimit-Test: rcpts/h 7 msgs/h 2 sum rcpts/h 8 sum msgs/h 2 total rcpts 2047 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 6A31A690481274CD10C10473507633206579CCED
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 2 total 880 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187274>

I wrote:
>[Neal Kreitzinger]
>> I assume by 'generated changes' you mean the automerge in git...
> 
> No.  And to your questions of why I want this with unpublished work:
> No.  Like I wrote, I'm talking about published commits.

Wait, I see - as-yet unpublished commits, yes.  Which seem best to me to
publish that way.  And which will get cherry-picked later, after commit
and testing.

-- 
Hallvard
