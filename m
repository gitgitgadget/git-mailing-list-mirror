From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: Broken Repo
Date: Mon, 7 May 2012 09:39:58 +0200
Message-ID: <20120507073713.GA863@hatchepsut.acc.umu.se>
References: <4FA74355.3020704@joezimjs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Zim <contact@joezimjs.com>
X-From: git-owner@vger.kernel.org Mon May 07 09:40:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRIYL-0001oY-9M
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 09:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab2EGHkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 03:40:09 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:33145 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364Ab2EGHkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 03:40:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 20B82227;
	Mon,  7 May 2012 09:40:07 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from hatchepsut.acc.umu.se (mail.acc.umu.se [IPv6:2001:6b0:e:2018::156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mk)
	by mail.acc.umu.se (Postfix) with ESMTPSA id 6FEB5226;
	Mon,  7 May 2012 09:40:06 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <4FA74355.3020704@joezimjs.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197240>

On Sun, May 06, 2012 at 10:36:53PM -0500, Joe Zim wrote:
> Hi, I'm new here. I'm using Github right now. I have a repository
> there and a local copy on my Windows 7 PC. I made a change,
> committed it, then attempted to push it. I got a strange error that
> I can't remember. Anyway, after several attempts I decided to just
> delete the local repository, restore it from github and try again
> later. I realize now that there were other ways this should have
> been handled, but right now it doesn't matter. I can't figure out
> how to restore a copy from Github and make this renewed repo the
> master branch. Can anyone give me a detailed, step by step answer
> please?
> 
> Thanks,
> Joseph Zimmerman

You deleted the local repository and want to clone it again from
GitHub right?

You can run 'git clone git@github.com:username/reponame.git' and
that should give you a new local repository cloned after the repository
on GitHub. Just replace username and reponame with the appropriate names
first and you should be up and running.

	Marcus
