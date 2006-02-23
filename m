From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 22 Feb 2006 18:05:56 -0800
Message-ID: <7v8xs2kewr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 23 03:06:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC5ro-0001Gp-Mo
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 03:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWBWCGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 21:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWBWCGA
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 21:06:00 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52887 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750729AbWBWCF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 21:05:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223020445.RHTV15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 21:04:45 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16631>


* The 'master' branch has these since the last announcement.

Junio C Hamano:
      gitview: ls-remote invocation shellquote safety.
      detect broken alternates.
      git-fetch: follow tag only when tracking remote branch.
      Merge fixes up to GIT 1.2.3

Nicolas Pitre:
      nicer eye candies for pack-objects
      also adds progress when actually writing a pack


* The 'next' branch, in addition, has these (not much changed).

 - git-rm from Carl Worth.  I think this is ready.

 - git-cvsserver from Martin.  I think this is ready.

 - git-annotate and git-blame from Ryan and Friedrik.

 - "thin pack" pack transfer optimization.

 - delta optimization from Nicolas Pitre.


* The 'pu' branch, in addition, has these.

 - "bind commit"

 - delta optimization bits from Nicolas.
