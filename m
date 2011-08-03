From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v2] commit: allow partial commits with relative paths
Date: Wed, 3 Aug 2011 21:28:28 +0200
Message-ID: <20110803192828.GA4228@toss>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
 <20110729133551.GA8707@toss.lan>
 <4E343534.8000604@drmicha.warpmail.net>
 <20110730170045.GA9900@toss.lan>
 <4E34399C.2080109@drmicha.warpmail.net>
 <20110730171347.GA10432@toss.lan>
 <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Reuben Thomas <rrt@sc3d.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:28:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoh7O-0003aw-NY
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab1HCT2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:28:34 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:62109 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750926Ab1HCT2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:28:33 -0400
Received: from localhost (p5B22C504.dip.t-dialin.net [91.34.197.4])
	by bsmtp.bon.at (Postfix) with ESMTP id E5F08130047;
	Wed,  3 Aug 2011 21:28:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178611>

Hi Junio,

On Tue, Aug 02, 2011 at 02:31:47PM -0700, Junio C Hamano wrote:
> 
> Perhaps "common_prefix()"?

Yes, I was thinking the same thing actually.

> Don't you also want to consolidate dir.c:common_prefix() with this?

I wasn't aware of it. I'm really swamped right now, but I'll take a
look at it soon.

Clemens
