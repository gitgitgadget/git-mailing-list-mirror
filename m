From: Nikolai Prokoschenko <nikolai@prokoschenko.de>
Subject: Re: Push over WebDAV and hooks
Date: Thu, 21 Aug 2008 22:13:47 +0200
Message-ID: <g8ki9r$j4o$1@ger.gmane.org>
References: <g8kgr5$e67$1@ger.gmane.org> <20080821201126.GY3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 22:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGYv-0001eR-Ql
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbYHUUOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbYHUUOG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:14:06 -0400
Received: from main.gmane.org ([80.91.229.2]:44043 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbYHUUOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:14:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWGXf-0004gc-7r
	for git@vger.kernel.org; Thu, 21 Aug 2008 20:13:59 +0000
Received: from f051108113.adsl.alicedsl.de ([78.51.108.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 20:13:59 +0000
Received: from nikolai by f051108113.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 20:13:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: f051108113.adsl.alicedsl.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
In-Reply-To: <20080821201126.GY3483@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93197>

Shawn O. Pearce wrote:
> Correct.  Hooks can only be executed if you use SSH or git:// to push
> the changes, as there is no remote execution available via WebDAV.

Thank you for the quick answer. I'm off to evaluating other options...

Nikolai
