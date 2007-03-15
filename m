From: Bill Lear <rael@zopyra.com>
Subject: Re: git protocol over port-forwarding
Date: Wed, 14 Mar 2007 18:33:52 -0600
Message-ID: <17912.38000.404237.850492@lisa.zopyra.com>
References: <17912.16608.852664.321837@lisa.zopyra.com>
	<Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
	<17912.29057.435478.123662@lisa.zopyra.com>
	<46a038f90703141514q5273e493r87f0ac7f52c1c216@mail.gmail.com>
	<et9vkm$2j4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdur-0006Ux-0r
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422782AbXCOAd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422787AbXCOAd6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:33:58 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61790 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422782AbXCOAd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:33:57 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2F0Xr405184;
	Wed, 14 Mar 2007 18:33:53 -0600
In-Reply-To: <et9vkm$2j4$1@sea.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42267>

On Thursday, March 15, 2007 at 00:14:32 (+0100) Jakub Narebski writes:
>...
>I think it could be done but with _two_ port forwarding, one from git
>port to ssh port or 5700 port, on your computer (probably reverse tunnel),
>second from 5700 port to git port... unless you configure git server
>to use different port...

Ok thanks to all, Jakub, Martin, Julian, for the comments.  I'll
go give our ssh "expert" hell.


Bill
