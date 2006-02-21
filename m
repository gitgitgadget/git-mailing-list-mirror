From: Dave Jones <davej@redhat.com>
Subject: Re: merging problems with Linus' kernel tree.
Date: Tue, 21 Feb 2006 15:29:35 -0500
Message-ID: <20060221202935.GC24159@redhat.com>
References: <20060221183306.GC22988@redhat.com> <Pine.LNX.4.64.0602211052360.30245@g5.osdl.org> <20060221191948.GE22988@redhat.com> <Pine.LNX.4.64.0602211153570.30245@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 21:29:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBe8l-00063O-PJ
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 21:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWBUU3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 15:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWBUU3k
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 15:29:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932322AbWBUU3k (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 15:29:40 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1LKTaSJ013122;
	Tue, 21 Feb 2006 15:29:36 -0500
Received: from nwo.kernelslacker.org (vpn83-122.boston.redhat.com [172.16.83.122])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1LKTa127675;
	Tue, 21 Feb 2006 15:29:36 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.5) with ESMTP id k1LKTaQq031245;
	Tue, 21 Feb 2006 15:29:36 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k1LKTZZC031244;
	Tue, 21 Feb 2006 15:29:35 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602211153570.30245@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16546>

On Tue, Feb 21, 2006 at 12:03:04PM -0800, Linus Torvalds wrote:

 > That, in turn, is usually due to an aborted merge.

Hmm.  (Recalls a power outage a few days ago).
I'll bet that's when it happened.

 > Do a "git checkout -f".

Fixed, thanks.

		Dave
