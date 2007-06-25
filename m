From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Add git-save script
Date: Mon, 25 Jun 2007 15:32:53 +0900
Message-ID: <200706250632.l5P6Wu6A028140@mi0.bluebottle.com>
References: <20070623220215.6117@nanako3.bluebottle.com> <Pine.LNX.4.64.0706231605160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 08:33:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2i8L-0002Fj-2K
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 08:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbXFYGc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 02:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbXFYGc6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 02:32:58 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:41181 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbXFYGc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 02:32:57 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5P6Wu6A028140
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 23:32:57 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:to:cc:date:from:subject:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:user-agent:x-trusted-delivery;
	b=E54mL0Ytz6cf/rWE+50uAOMTUy9+AM7TYZGfgZpKoHcdSbGfVpWDJSTsU2e+Xr7Dn
	y1nal1KZSTi1F3YTwbT+VUiQklA30LJUj3Ib17gfj9lcGEXOUEyG97hm7FzW/Q8
Received: from localhost (internal.bluebottle.com [206.188.24.43])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5P6WreX001948;
	Sun, 24 Jun 2007 23:32:56 -0700
Received: from 86-15-251-64.serverpronto.com (86-15-251-64.serverpronto.com [64.251.15.86]) 
	by mail.bluebottle.com (IMP) with HTTP 
	for <nanako3@bluebottle.com@localhost>; Mon, 25 Jun 2007 15:32:53 +0900
In-Reply-To: <Pine.LNX.4.64.0706231605160.4059@racer.site>
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Trusted-Delivery: <8feece2a0816e878e5ac0335cf02e53b>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50863>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi,
> 
> On Sat, 23 Jun 2007, Nanako Shiraishi wrote:
> 
> > Here is how to use my script:
> > 
> >     $ git save
> >     $ git pull
> >     $ git save restore
> 
> This use case has been discussed often, under the name "git-stash".
> 
> Ciao,
> Dscho

Thank you for your comments.  Do you suggest I rename the script to git-stash and re-submit after fixing according to Junio's comments?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com
