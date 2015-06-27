From: John Lee <jjl@pobox.com>
Subject: Re: Staging commits with visual diff tools?
Date: Sun, 28 Jun 2015 00:23:53 +0100 (BST)
Message-ID: <alpine.DEB.2.10.1506272359240.31567@alice>
References: <alpine.DEB.2.10.1505262147230.3709@alice> <20150531015956.GA64502@gmail.com> <alpine.DEB.2.10.1505311029210.3664@alice> <20150601022515.GA66417@gmail.com> <alpine.DEB.2.10.1506012034120.2730@alice>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 01:24:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8zSM-0006u6-K1
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 01:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbbF0XYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 19:24:14 -0400
Received: from mxout-07.mxes.net ([216.86.168.182]:16097 "EHLO
	mxout-07.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbF0XYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 19:24:11 -0400
Received: from alice.home (unknown [81.152.186.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 9543422E200
	for <git@vger.kernel.org>; Sat, 27 Jun 2015 19:24:10 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.10.1506012034120.2730@alice>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272863>

On Mon, 1 Jun 2015, John Lee wrote:

> On Sun, 31 May 2015, David Aguilar wrote:
>> Were you thinking of something like this, or something else?
>> Can you describe your use case a bit more?
>
> I think now I should just publish my script and then it will be very clear 
> what I'm talking about.  If somebody then wants to add a similar feature to 
> git-cola, or even git itself, that would be great.
>
>
> John
>

Here it is:

https://github.com/jjlee/git-meld-index

Hasn't seen use for real yet, so be a bit cautious with it.

Comments / patches / whatever appreciated.


John
