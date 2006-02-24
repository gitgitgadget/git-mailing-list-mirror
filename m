From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitview: Use monospace font to draw the branch and tag name
Date: Fri, 24 Feb 2006 03:17:00 -0800
Message-ID: <7vr75tc8gj.fsf@assigned-by-dhcp.cox.net>
References: <43FC8BF2.60205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 12:17:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCawc-0005ku-Pr
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 12:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWBXLRD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 06:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWBXLRD
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 06:17:03 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57569 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750994AbWBXLRC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 06:17:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224111546.WCWJ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 06:15:46 -0500
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
In-Reply-To: <43FC8BF2.60205@gmail.com> (Aneesh Kumar K. V.'s message of "Wed,
	22 Feb 2006 21:36:10 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16693>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> This patch address the below:
> Use monospace font to draw branch and tag name
> set the font size to 13.

I have an impression that hardcoding UI policy like this is
generally frowned upon.
