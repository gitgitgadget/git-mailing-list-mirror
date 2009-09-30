From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Compact view of history in gitk
Date: Wed, 30 Sep 2009 20:41:08 +0200
Message-ID: <4AC3A644.9030407@dirk.my1.cc>
References: <4AC1F435.4030802@ubicom.com> <4AC1F88E.7080802@viscovery.net> <46a038f90909290821g4bb9cecewace8c8a516b74c78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Yakup Akbay <yakbay@ubicom.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:51:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt4Gp-0006n8-56
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 20:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbZI3SvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 14:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZI3SvM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 14:51:12 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:34307 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZI3SvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 14:51:12 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2009 14:51:12 EDT
Received: from [84.176.88.234] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Mt49H-0000B1-LK; Wed, 30 Sep 2009 20:43:36 +0200
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <46a038f90909290821g4bb9cecewace8c8a516b74c78@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129349>

Am 29.09.2009 17:21 schrieb Martin Langhoff:
> On Tue, Sep 29, 2009 at 2:07 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> I think, --simplify-by-decoration comes close, even though it may not be
>> 100% what you describe.
> 
> That is awesome.
> 
> Awesomer would be teaching gitk to expand (un-simplify) parts of it.
> Probably a pig of a project to do though :-/
> 
> 
> 
> m

I'm proud to tell that one might also use gitk's
dialog 'View -> Edit view... (F4)' and then activate
the 'Simple history' checkbox. :-)

Gitk knows about that since Git v1.6.4-rc0.

However, it doesn't do the awesomer part.

Dirk
