From: John Lee <jjl@pobox.com>
Subject: Re: Staging commits with visual diff tools?
Date: Sun, 28 Jun 2015 18:56:58 +0100 (BST)
Message-ID: <alpine.DEB.2.10.1506281852230.31567@alice>
References: <alpine.DEB.2.10.1505262147230.3709@alice> <20150531015956.GA64502@gmail.com> <alpine.DEB.2.10.1505311029210.3664@alice> <20150601022515.GA66417@gmail.com> <alpine.DEB.2.10.1506012034120.2730@alice> <alpine.DEB.2.10.1506272359240.31567@alice>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 19:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9Gpl-0002PB-Ty
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 19:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbbF1R5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 13:57:14 -0400
Received: from mxout-07.mxes.net ([216.86.168.182]:21321 "EHLO
	mxout-07.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbF1R5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 13:57:13 -0400
Received: from alice.home (unknown [81.152.186.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id C4DB022E261
	for <git@vger.kernel.org>; Sun, 28 Jun 2015 13:57:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.10.1506272359240.31567@alice>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272921>

On Sun, 28 Jun 2015, John Lee wrote:

> Here it is:
>
> https://github.com/jjlee/git-meld-index
>
> Hasn't seen use for real yet, so be a bit cautious with it.
>
> Comments / patches / whatever appreciated.
>
>
> John
>

By the way despite the name it should support all git difftools (it uses 
the same git config parameters and git-mergetool--lib code as git itself).

I just used it to make some changes to its own project, quite nice :-)

It now has a --help manpage and some relevant options from git-difftool.


John
