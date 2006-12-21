From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn question
Date: Thu, 21 Dec 2006 10:21:31 -0800
Message-ID: <m2fyb9qfdg.fsf@ziti.local>
References: <f2e8061d0612210927p2d18adb4u995ce16702fc3b08@mail.gmail.com>
	<f2e8061d0612210934m2f147a1bl55d7152cc85f6f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 19:21:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxSXx-0003eu-Rp
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 19:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422998AbWLUSVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 13:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbWLUSVf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 13:21:35 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:9594 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422998AbWLUSVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 13:21:34 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1029183nze
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 10:21:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=WcF5K/t/vrZHxEDsrTFVxBqA9cYCEpvES4zF1+uo4Tysv8Scqto5S1tICjpoImpcUAeJrQxyZiQTo6pKWWaceXuKkcCTZdfbzDqvfLvXMilLj20IEZhdUl3TU5s9IGe0JeUmsO5K4cBVuLzls2rBKXvnh3cQbKdIeJUEbzwAKh0=
Received: by 10.65.210.18 with SMTP id m18mr11583569qbq.1166725293526;
        Thu, 21 Dec 2006 10:21:33 -0800 (PST)
Received: from ziti.local ( [140.107.181.122])
        by mx.google.com with ESMTP id f13sm11780722qba.2006.12.21.10.21.32;
        Thu, 21 Dec 2006 10:21:32 -0800 (PST)
To: "Joseph Carrafa" <carrafaj@gmail.com>
In-Reply-To: <f2e8061d0612210934m2f147a1bl55d7152cc85f6f3e@mail.gmail.com> (Joseph Carrafa's message of "Thu, 21 Dec 2006 12:34:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35078>

"Joseph Carrafa" <carrafaj@gmail.com> writes:

> I have a question concerning using git with an svn repo.  I have a
> local git repo that was created with git svn init
> $SVNROOT/branches/2.2.0.  we moved the svn branch to
> $SVNROOT/branches/2.3.0.  how can i change my local git repo to commit
> to the new svn branch, $SVNROOT/branches/2.3.0?

See this thread:
http://article.gmane.org/gmane.comp.version-control.git/33715/match=seth+falcon

And read the Advanced Example: Tracking a Reorganized Repository in
the git-svn man page.

+ seth
