From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH/RFC] introduce GIT_WORK_TREE environment variable
Date: Wed, 4 Apr 2007 23:04:39 +0200
Message-ID: <20070404210439.GA24245@moooo.ath.cx>
References: <20070328141505.GA16600@moooo.ath.cx> <20070404140853.GA31372@moooo.ath.cx> <7vslbg2d2t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZCfg-0000t0-Ob
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 23:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXDDVEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 17:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXDDVEq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 17:04:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:54528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751477AbXDDVEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 17:04:41 -0400
Received: (qmail invoked by alias); 04 Apr 2007 21:04:40 -0000
Received: from pd9eba5e8.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.165.232]
  by mail.gmx.net (mp045) with SMTP; 04 Apr 2007 23:04:40 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19fHOE75+VfLODE0sQFuxRpWgmFZWs2SuUbIC0mJs
	AAn9lnBAskCR1T
Content-Disposition: inline
In-Reply-To: <7vslbg2d2t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43776>

Junio C Hamano <junkio@cox.net> wrote:
> My impression was that you already received a couple responses
> which were not yet answered.

I just fixed the two things noted in reply to the patch.  I was
waiting for feedback if it is desired to read the whole configuration
from setup_git_directory_gently() and perhaps a comment on the rewrite
of it.
