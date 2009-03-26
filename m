From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Improve tags
Date: Fri, 27 Mar 2009 06:53:56 +0900
Message-ID: <20090327065356.6117@nanako3.lavabit.com>
References: <49CB798B.4090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Etienne Vallette d'Osia" <dohzya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 22:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxZE-0007P9-VB
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759031AbZCZVyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbZCZVyo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:54:44 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33534 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbZCZVyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 17:54:43 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 13CF311B7D8;
	Thu, 26 Mar 2009 16:54:41 -0500 (CDT)
Received: from 9316.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id OR8RJU3KVYPO; Thu, 26 Mar 2009 16:54:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tMmXDgQ1gqGxQJQsWhHPwRbEfcwNMzZKK8pR7DPWxb0GG0blBaDQrG2rJXQRqrw9SDeytONek9wW/wyEEBpEffDoPiBDO+n5UtsNGz9BZvreSJLu5/DJUsP+nwirtkB60nlE5fTK4w4Tb3tBwcShS7dQKItFm/ARdzpOsIJgH18=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <49CB798B.4090107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114831>

Quoting "Etienne Vallette d'Osia" <dohzya@gmail.com>:

> In addition, branches are a way to specify streams,
> not a way to specify an aim for a commit.
> (like in ruby a class is a method container, not a type)
> So branch names are often like next, pu, dev, test, stupid-idea, etc.
> They are totally useless for tracking aims.

Why should that be?  'next' clearly states the aim (it is to serve as an
integration testing area for the possible new features for the next
release).

Quoting http://article.gmane.org/gmane.comp.version-control.git/113812

 (1) Name your (eh, "my") branch just like you name your function.

     You probably learned in programming 101 course the importance of
     giving a good name to your functions.  The same principle applies.
     When I see kb/checkout-optim branch, I know it is about optimizing
     the checkout command, and it came from Kjetil Barvik.  I can tell
     that jc/maint-1.6.0-read-tree-overlay is about the bugfix to the
     "overlay" feature of read-tree command, and the fix would apply as
     far back as the 1.6.0.X series, not just the current maintenance.


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
