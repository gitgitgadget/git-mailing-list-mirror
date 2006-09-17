From: Jon Loeliger <jdl@jdl.com>
Subject: Re: Setting up Password protected repositories?
Date: Sat, 16 Sep 2006 21:07:01 -0500
Message-ID: <E1GOm3h-0005jq-5u@jdl.com>
References: <E1GOktx-0005JY-ER@jdl.com>  <7virjn8eua.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 04:07:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOm3t-0004Vi-EB
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 04:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWIQCHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 22:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWIQCHG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 22:07:06 -0400
Received: from colo.jdl.com ([66.118.10.122]:65479 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964909AbWIQCHE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 22:07:04 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GOm3h-0005jq-5u; Sat, 16 Sep 2006 21:07:03 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Your message of "Sat, 16 Sep 2006 18:24:45 PDT."
             <7virjn8eua.fsf@assigned-by-dhcp.cox.net> 
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27150>

So, like, the other day Junio C Hamano mumbled:
> 
> It all depends on how you start git-daemon, but the last
> parameters to git-daemon are path whitelist so presumably
> placing the private repository outside of it should be enough.
> 
> Or am I missing something deeper?

I want git-daemon to serve up the repository.
I just want to have it served to people who can
supply a password or have an ssh key in place.

jdl
