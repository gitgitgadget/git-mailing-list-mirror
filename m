From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Thu, 01 Sep 2005 17:38:39 -0700
Message-ID: <7vek88tib4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0508171341380.23242@iabervon.org>
	<Pine.LNX.4.63.0508172156090.17234@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0508171630140.23242@iabervon.org>
	<Pine.LNX.4.63.0508180009180.18104@wgmdd8.biozentrum.uni-wuerzburg.de>
	<430C8C31.1070902@progeny.com>
	<7v4q9eak9k.fsf@assigned-by-dhcp.cox.net>
	<43174090.5070503@progeny.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 02:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAzZs-0006mz-AU
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 02:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030611AbVIBAim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 20:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbVIBAil
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 20:38:41 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17141 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030611AbVIBAil (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 20:38:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050902003839.HZKG2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Sep 2005 20:38:39 -0400
To: Tim Ottinger <tottinge@progeny.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8005>

Tim Ottinger <tottinge@progeny.com> writes:

> git-update-cache for instance?
> I am not sure which 'cache' commands need to be 'index' now.

Logically you are right, but I suspect that may not fly well in
practice.  Too many of us have already got our fingers wired to
type cache, and the glossary is there to describe both cache and
index.

 
