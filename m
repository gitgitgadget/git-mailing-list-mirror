From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 22:36:57 +0000
Message-ID: <20130212223657.GJ2270@serenity.lan>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:37:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5OTm-0000lW-BO
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab3BLWhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:37:08 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:58877 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab3BLWhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:37:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 468E6161E27E;
	Tue, 12 Feb 2013 22:37:06 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1fzjLIqTfSf; Tue, 12 Feb 2013 22:37:05 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 94CBE161E388;
	Tue, 12 Feb 2013 22:36:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130212222508.GG12240@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216210>

On Tue, Feb 12, 2013 at 02:25:08PM -0800, Jonathan Nieder wrote:
> John Keeping wrote:
> 
> >   Documentation/Makefile: fix inherited {html,info,man}dir
> 
> This doesn't seem to have hit the list.

Hmm... it made it to gmane:

http://article.gmane.org/gmane.comp.version-control.git/216188
