From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Configure a prompt callback for gnome_keyring.
Date: Thu, 29 Aug 2013 17:38:13 +0000
Message-ID: <20130829173813.GA25630@dcvr.yhbt.net>
References: <20130618163609.GD10217@login.drsnuggles.stderr.nl>
 <1371573490-21973-1-git-send-email-matthijs@stdin.nl>
 <20130829094205.GO10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:48:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6K7-0007Md-JX
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab3H2Rrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:47:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40277 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab3H2Rrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 13:47:55 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2013 13:47:55 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2C81F70D;
	Thu, 29 Aug 2013 17:38:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130829094205.GO10217@login.drsnuggles.stderr.nl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233293>

Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Hi folks,
> 
> any chance this patch can be merged?

It's probably fine.  Does anybody else have testing/feedback?  I haven't
used git-svn/SVN in years, and I don't use GNOME (nor much GUI).
