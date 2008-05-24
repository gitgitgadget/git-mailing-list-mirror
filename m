From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Sat, 24 May 2008 09:24:58 +0800
Organization: (kooxoo Corp.)
Message-ID: <20080524012458.GA15851@kooxoo235>
References: <200805232221.45406.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 24 03:25:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JziWC-0002an-Ks
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 03:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbYEXBZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 21:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbYEXBZE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 21:25:04 -0400
Received: from mail.qikoo.org ([60.28.205.235]:45150 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753854AbYEXBZC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 21:25:02 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 945A0470AE; Sat, 24 May 2008 09:24:58 +0800 (CST)
Mail-Followup-To: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200805232221.45406.trast@student.ethz.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82785>

* Thomas Rast <trast@student.ethz.ch> [2008-05-23 22:21:43 +0200]:

> Adds a new option 'e' to the 'add -p' command loop that lets you
> discard or keep one hunk line at a time.  This is useful if there are
> no unchanged lines in the middle of the hunk, so 's' will not work,
> but you would still like to split it.
> 
Wow, nice feature, although i havn't tried.
