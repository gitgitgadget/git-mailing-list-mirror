From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 24 Aug 2007 02:28:06 +0200
Organization: At home
Message-ID: <fal8ll$68a$1@sea.gmane.org>
References: <7vejhvw0fy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 02:27:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ION1d-0001xd-MO
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 02:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760211AbXHXA1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 20:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764602AbXHXA1m
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 20:27:42 -0400
Received: from main.gmane.org ([80.91.229.2]:36318 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759835AbXHXA1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 20:27:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ION1W-0000fH-Qy
	for git@vger.kernel.org; Fri, 24 Aug 2007 02:27:38 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 02:27:38 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 02:27:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56542>

Junio C Hamano wrote:

> Hopefully we can do the final without another -rc sometime early
> next week.

By the way, there is no info in RelNotes about performance fix of the O(n^2)
wrt number of files behavior.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
