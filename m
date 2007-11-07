From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about shared repositories
Date: Wed, 7 Nov 2007 08:35:31 +0100
Message-ID: <DED2A61B-B5AE-4BAA-942A-18A61924611E@zib.de>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org> <4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org> <47310ACF.4030103@gmail.com> <Pine.LNX.4.64.0711070053320.4362@racer.site> <3abd05a90711061736r4c969cddj348c006615ffbdd6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Francesco Pretto <ceztkoml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 08:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpfRf-00004z-Ri
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 08:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbXKGHfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 02:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755997AbXKGHfK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 02:35:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:62913 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913AbXKGHfI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 02:35:08 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA77YHHo005744;
	Wed, 7 Nov 2007 08:34:41 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1a8b8.pool.einsundeins.de [77.177.168.184])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA77YDJS019983
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 7 Nov 2007 08:34:13 +0100 (MET)
In-Reply-To: <3abd05a90711061736r4c969cddj348c006615ffbdd6@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63776>


On Nov 7, 2007, at 2:36 AM, Aghiles wrote:

> Hello,
>>
>> Remember, those who read "git for CVS users" are _unwilling_ to  
>> spend the
>> time reading git documentation (at least for the most part).  If they
>> encounter something which is not useful to them, they will not  
>> just ignore
>> it, they will stop reading.
>>
>
> I must disagree with this analysis (although I didn't read the  
> content of the
> patch you are commenting). People that are not really interested in  
> git will
> find many reasons to stop reading the manual anyway. Those who really
> want to migrate (such as we did) are looking for every tiny bit of  
> information.
> (We googled git commands and error messages because we didn't
> find what we needed in the docs)

Could you be a bit more specific? What are the most important
points that you did not found in the documentation?

It would be interesting if you could share some details. Sending
patches that would fix the deficiencies would even be
superior ;)


> The docs are not perfect and somewhat unequal in content but I prefer
> more information than less, at this particular stage of git  
> development.

I agree if it is git specific information. But, personally,
I'd get a bit annoyed if a git specific document tried to
teach me how to manage Unix accounts. BTW, useradd and such
would not help me at all, because I need to talk to my admin
anyway and he adds an account to the LDAP database.

	Steffen
