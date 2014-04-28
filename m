From: Mark Nudelman <markn@greenwoodsoftware.com>
Subject: Re: Harmful LESS flags
Date: Mon, 28 Apr 2014 14:38:04 -0700
Message-ID: <535ECA3C.8090604@greenwoodsoftware.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor> <20140424001126.GG15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>, d9ba@mailtor.net
X-From: git-owner@vger.kernel.org Mon Apr 28 23:44:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WetLd-0002Cn-DT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbaD1VoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 17:44:21 -0400
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:34576 "EHLO
	qmta05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751915AbaD1VoU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 17:44:20 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Apr 2014 17:44:20 EDT
Received: from omta17.emeryville.ca.mail.comcast.net ([76.96.30.73])
	by qmta05.emeryville.ca.mail.comcast.net with comcast
	id vZNm1n0031afHeLA5ZeEjV; Mon, 28 Apr 2014 21:38:14 +0000
Received: from [192.168.1.107] ([50.184.101.91])
	by omta17.emeryville.ca.mail.comcast.net with comcast
	id vZeD1n0071yK2V68dZeDXF; Mon, 28 Apr 2014 21:38:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140424001126.GG15516@google.com>
X-Enigmail-Version: 1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398721094;
	bh=uKFJilqI+TMlXDjji3lUBJbalqppuMLoIU0za7Y7k2w=;
	h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
	 Content-Type;
	b=pzKsvZClTZ1Kp2kGO4tlcsWZ4kRQOacNLnrhvsxt717pRwp6hQsxJ7jeXKIm1b6oW
	 rK11zjijXR+Nu671Wzv+IqMdmASc7pb8wueB83u7fVlLxqaP7pM6TcDjAwW741IAts
	 JCBZ6doZFYlL8TBJx/iPXePm2QOn9mHLv/4S4x9rduNf5A2/JLMosha94z3INLE+MK
	 VkwdWOTt6pdIcQBS7dvlHG6P77jKxWNz3tLIcZxRtOKq6mFEvywlXwdg2YC4lIsMgM
	 iGj+zNHc4hqOaD5IbIDSghAONjQkafFpC4oZtQvRDV/UJLq7l0Q8tBXMsEqY24jr+T
	 0B4ojin0OL9Ug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247458>

On 4/23/2014 5:11 PM, Jonathan Nieder wrote:
> That sounds like a nice feature request for 'less': a marker on the
> right margin when --chop-long-lines is in use and a line has been
> chopped.  I don't see it at
> http://www.greenwoodsoftware.com/less/bugs.html#enhance so maybe no
> one else has thought of it yet.
> 
> Mark, what do you think?
> 

Hi Jonathan,
This seems reasonable.  I actually thought that something like this was
already implemented, and displayed in the status column when -J is in
effect.  But I must have dreamed that or something.  I'll add this as an
enhancement request.

--Mark
