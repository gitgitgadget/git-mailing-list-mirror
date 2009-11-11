From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Girocco hosting infrastructure v1.0
Date: Wed, 11 Nov 2009 12:03:58 +0100
Message-ID: <4AFA9A1E.5050107@drmicha.warpmail.net>
References: <20091110104027.GI17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Nov 11 12:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Azn-0006ho-A9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 12:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbZKKLED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 06:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZKKLEC
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 06:04:02 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49791 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053AbZKKLEB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 06:04:01 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B996BEF91;
	Wed, 11 Nov 2009 06:04:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 11 Nov 2009 06:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=a8ALry7W8PvpineonLtX/YuvOdw=; b=oCgord2xdF/6bSEP6dSLIAB9U6nTJlAxHXcoMsZIs4dL8qzVWM24jtopMNJeUUsEfOrldFln5kGJ/OmSwNGdQLmhTJptjcTbDyhA7SnxORTbZwzHQMinHwBB0Tl4LSIzdvve7A6L7eI8fQpAmM4cjnoXenZ0UFSUJ4AqTP5AGT8=
X-Sasl-enc: fXaPVANNnJW6j+Y0l+Xn5GXKGbrAg8F1xYUpGyh2ib7b 1257937445
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8CD341A403;
	Wed, 11 Nov 2009 06:04:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091111 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <20091110104027.GI17748@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132639>

Petr Baudis venit, vidit, dixit 10.11.2009 11:40:
>   Hello!
>
>   I would like to announce Girocco-1.0, the first stable release of
> a universal Git project hosting infrastructure. You can get it at
...
>   If you are used to repo.or.cz, what's new in Girocco at the user's
> end?
>
>   * Friendlier homepage.
>
>   * Friendlier project/user management interface.
>
>   * Friendlier mirror cloning process (you can see the progress in your
>     browser).
>
>   * Support for automatic Git mirroring of SVN repositories.

Hi there,

thanks for everything. I'm glad things aren't "too friendly": I never
know how to navigate the "shinier" hosting alternatives...

How does the svn mirroring work? Do I simply enter a svn:// url for
"Anywhere"? Is it always standard layout (git svn clone -s)?
Can I specify an authors file?

Michael
