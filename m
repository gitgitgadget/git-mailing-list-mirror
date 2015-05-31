From: John Lee <jjl@pobox.com>
Subject: Re: Staging commits with visual diff tools?
Date: Sun, 31 May 2015 10:36:52 +0100 (BST)
Message-ID: <alpine.DEB.2.10.1505311029210.3664@alice>
References: <alpine.DEB.2.10.1505262147230.3709@alice> <20150531015956.GA64502@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 11:37:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yyzg5-0007ur-0E
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 11:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758221AbbEaJhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 05:37:04 -0400
Received: from mxout-07.mxes.net ([216.86.168.182]:25032 "EHLO
	mxout-07.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107AbbEaJhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 05:37:01 -0400
Received: from alice.home (unknown [81.152.189.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 87F1622E25F
	for <git@vger.kernel.org>; Sun, 31 May 2015 05:37:00 -0400 (EDT)
In-Reply-To: <20150531015956.GA64502@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270330>

On Sat, 30 May 2015, David Aguilar wrote:

> On Tue, May 26, 2015 at 09:50:49PM +0100, John Lee wrote:
>> Hi
>>
>> Does anybody have code to stage commits using a the visual
>> diff/merge tools supported by git-difftool?  Is there support in git
...
> I'm a g/vim user, so git-cola is finely tuned for keyboard
> usage.  If we implement these feature in Git, we should consider
> providing the same workflows/hotkeys as cola.

Just to be clear I'm not planning on contributing my script back to git, 
it will just be a standalone script in a separate repo.

I'll give git-cola a try, thanks.  I just ran it and see it supports e.g. 
right click to stage and launching difftools -- does it also support 
launching a difftool to edit the index?


John
