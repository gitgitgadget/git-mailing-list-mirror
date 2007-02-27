From: Bill Lear <rael@zopyra.com>
Subject: Re: Pulling peer's branch and getting tracking branch created
Date: Mon, 26 Feb 2007 19:07:10 -0600
Message-ID: <17891.33854.166609.651544@lisa.zopyra.com>
References: <17891.32095.655545.637691@lisa.zopyra.com>
	<7v7iu4l8k0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 02:07:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqoJ-0006yi-Bl
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 02:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbXB0BHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 20:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbXB0BHP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 20:07:15 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61826 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030567AbXB0BHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 20:07:14 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1R17AO08397;
	Mon, 26 Feb 2007 19:07:10 -0600
In-Reply-To: <7v7iu4l8k0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40685>

On Monday, February 26, 2007 at 16:59:27 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> I can't seem to figure out the correct magic to get my buddy's branch,
>> and create the appropriate tracking branch at the same time without
>> doing a clone.
>
>I'll cheat and ask "git show b6f5da1e" ;-).
>
>	$ git remote add -f -m master bob ../bob.git/

Sorry, should have asked: what doe "-f -m master" mean?  I looked in
the man page, but didn't see anything on this.


Bill
