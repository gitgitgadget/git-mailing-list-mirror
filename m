From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 21:27:06 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511182127.06958.ismail@uludag.org.tr>
References: <200511181833.40048.ismail@uludag.org.tr> <200511181926.10357.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 20:27:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBts-0000WK-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVKRT1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVKRT1x
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:27:53 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:681 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750883AbVKRT1w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 14:27:52 -0500
Received: from dsl.dynamic8599158195.ttnet.net.tr (unknown [85.99.158.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 79C4BAADDD
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 21:27:46 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <200511181926.10357.ismail@uludag.org.tr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12250>

On Friday 18 November 2005 19:26, you wrote:
> On Friday 18 November 2005 18:33, you wrote:
> > Hi all,
> >
> > I am trying to parse git's rss feed and now xml parsers seems to choke on
> > it because of an error in the produced feed. Looking at
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=rs
> >s
> >
> > line 781 says :
> >
> > On Thu, 17 Nov 2005, David G\363mez wrote:<br/>
> >
> > which is part of the commit :
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=co
> >mm it;h=05b8b0fafd4cac75d205ecd5ad40992e2cc5934d
>
> Ok looks like this text is latin-1 encoded although xml is served as utf-8.

Any comments on this?

Regards,
ismail
