From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Fri, 05 May 2006 17:18:06 +0200
Organization: At home
Message-ID: <e3fqb9$hed$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 05 17:19:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc253-0000RJ-Ur
	for gcvg-git@gmane.org; Fri, 05 May 2006 17:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWEEPSy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 11:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWEEPSy
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 11:18:54 -0400
Received: from main.gmane.org ([80.91.229.2]:60136 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751446AbWEEPSx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 11:18:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fc24W-0000Iq-5I
	for git@vger.kernel.org; Fri, 05 May 2006 17:18:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 17:18:24 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 17:18:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19612>

Linus Torvalds wrote:

> So what you'd get is a _really_ cut down history that doesn't contain any
> commit history at all (just distinct "points in commit history time"), but
> that _does_ contain all the objects that the commits point to.

So we would get 'skin-deep clone' rather than 'shallow' one?

-- 
Jakub Narebski
Warsaw, Poland
