From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Sat, 07 Jun 2008 06:46:34 +0900
Message-ID: <200806062147.m56LlK5Q030355@mi0.bluebottle.com>
References: <alpine.DEB.1.00.0806061911300.1783@racer> <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Cedric Vivier <cedricv@neonux.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4jnH-0003Em-5I
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664AbYFFVrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbYFFVrW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:47:22 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:49241 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757817AbYFFVrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:47:21 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m56LlK5Q030355
	for <git@vger.kernel.org>; Fri, 6 Jun 2008 14:47:20 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=U0LeHW08CHEtmimGAVF/oyRb3TBH6O5YtHeSk3mwurp9zPKKBvgGD10r2V2qArppY
	igRrHlkIzlISgWVqVteLi+tMSwBFtEsWHVepeGu2pX9+WNyZa+0YK+seF4I3cck
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m56Ll4uv026134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jun 2008 14:47:14 -0700
In-Reply-To: <alpine.DEB.1.00.0806061911300.1783@racer>
X-Trusted-Delivery: <823df46ccce570d4b43ddd6dbfd0c0cf>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84121>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi,
>
> On Fri, 6 Jun 2008, Paolo Bonzini wrote:
>
>> > What about people preferring the status quo?  I think a command line 
>> > option would be in order.'
>> 
>> config option seems more useful.
>
> Except, of course, if you have a script that wants to override whatever 
> the user set in her config.

But I think that is not an issue.  Isn't "git branch" a Porcelain?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com/tag/2
