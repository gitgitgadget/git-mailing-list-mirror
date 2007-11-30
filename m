From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Fri, 30 Nov 2007 02:53:54 +0100
Message-ID: <200711300253.55759.jnareb@gmail.com>
References: <200711282339.59938.jnareb@gmail.com> <200711300118.28145.jnareb@gmail.com> <200711300226.54338.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixv5G-0005Ss-6o
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238AbXK3ByH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763761AbXK3ByG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:54:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:45284 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763626AbXK3ByD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:54:03 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2085021nfb
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 17:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=qW6Tf8aN1q7JL4QIoOoIKwpItv3My6+zc8Zt5iPgei0=;
        b=hfBEIwU/QLPCxzObSeQ62eg0VWviLTNCqCMli0p6hrtCX13xNp7j8b7YwSOkPQ/inmB5k2u0zuHSnwBPu4YXIvMrhtIbTy9YwBRqKu2+CSXgQIJulakYf/yAltX+aR7BbqUaY2W0beZ2F2zRI3fa1H1CdKs1oN+7Ytgz6t2FENg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QqSSoKJfVftE79FIYwq7rhj4C9y8/7O0C0AVAW6lu+aEIUeGt/K/eCbcDVbIShtQRp525s/LGFpYWx3ZDcgO2xo8KUumURjn34UyO/7dX3JbwDlZftJ/6TlcJleuksErdG/MwY4eCuJ75TUnkmX+iph9PJDXn+pTop3rjWnjJU8=
Received: by 10.86.54.3 with SMTP id c3mr4500134fga.1196387640821;
        Thu, 29 Nov 2007 17:54:00 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.205.222])
        by mx.google.com with ESMTPS id 31sm8591871fkt.2007.11.29.17.53.58
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Nov 2007 17:53:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200711300226.54338.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66600>

On Fri, 30 Nov 2007, Johan Herland wrote:
> On Friday 30 November 2007, Jakub Narebski wrote:
>> On Thu, 29 Nov 2007, Alex Riesen wrote:
>>> Jakub Narebski, Thu, Nov 29, 2007 03:26:12 +0100:
>> 
>>>> +             <s id="git">
>>>> +                 Medium. There's Git User's Manual, manpages, some
>>>> +                 technical documentation and some howtos.  All
>>>> +                 documentation is also available online in HTML format;
>>>> +                 there is additional information (including beginnings
>>>> +                 of FAQ) on git wiki.
>>>> +                 Nevertheles one of complaints in surveys is insufficient
>>> 
>>> "Nevertheless" (two "s").
>>> 
>>> BTW, I wouldn't call the level of documentation "Medium" when compared
>>> to any commercial SCM. How can they earn more than "a little", when
>>> compared to any opensource program?
>> 
>> Source code is not [user level] documentation.
>> 
>> But perhaps it should be "Good" instead of "Medium", although I think
>> not "Excellent".
> 
> If we try to compare ourselves to what's closest, i.e. Mercurial, I would
> say that Git's documentation is probably on par with what Mercurial has to
> offer. Their "Documentation" entry in the comparison is as follows:
> 
> "Very good. There's an overview and tutorial on the web site, and integrated
> help for every command."
> 
> I say we go for something similar.

Well, at least according to surveys results people perceive
"The Mercurial Book" (hgbook) as better documentation than
"Git User's Manual" + tutorials. See for example frequent requests
for "The Git Book" patterned after hgbook and/or svnbook.

BTW. the list was meant to be updated by contributors who added
SCMs, but it doesn't liik lik it is...

-- 
Jakub Narebski
Poland
