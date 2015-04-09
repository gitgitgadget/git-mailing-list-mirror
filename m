From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [WIP/RFH/PATCH 3/3] t/lib-git-svn: adjust config to apache 2.4
Date: Thu, 9 Apr 2015 19:11:23 +0000
Message-ID: <20150409191123.GA1931@dcvr.yhbt.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
 <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net>
 <20150408202615.GA12154@dcvr.yhbt.net>
 <55264763.6050703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:11:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgHrP-00044V-84
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 21:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098AbbDITL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 15:11:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54232 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932851AbbDITL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 15:11:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BBBB1F488;
	Thu,  9 Apr 2015 19:11:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <55264763.6050703@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266998>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> So debian stable has apache 2.2? That explains why many don't see these
> problems.

Right.

> So, before 3/3, t9118 and such do run the web server and test git-svn
> against that for you?

Yes.
