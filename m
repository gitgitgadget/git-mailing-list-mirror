From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Pseudonymous commits
Date: Thu, 25 Mar 2010 16:57:22 -0700 (PDT)
Message-ID: <m34ok4j6qi.fsf@localhost.localdomain>
References: <4BAADF34.3080806@gmail.com>
	<4BA51E6B-7325-465A-B23E-7F3C5BF87700@mit.edu>
	<4BAAE981.4040205@gmail.com>
	<alpine.LFD.2.00.1003251459540.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Theodore Tso <tytso@MIT.EDU>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 01:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuxAz-0000YB-JV
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 01:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab0CZANL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 20:13:11 -0400
Received: from mail-fx0-f175.google.com ([209.85.220.175]:44553 "EHLO
	mail-fx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab0CZANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 20:13:09 -0400
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2010 20:13:09 EDT
Received: by fxm23 with SMTP id 23so1028737fxm.1
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 17:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=TXxfXC79m0ERmlIhlG8GzfTaeOanc/IprTFHqG20p0Y=;
        b=hLFPGrIiyXWJiuVakLeAfPtrd7XIxLA8watRQkZxozxX9yRSIT/NQ0nCxIdyJTg+ye
         qTKF7MMqfQQPApRe3ljByuArYiwHtYiqO6jb6oddriSsiCnZgZzfQfzb9tK4I8pGzdrt
         GrXXJ1RSJkkjClhtU0MQ0doSZYp/L/vAzKV9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=o9j3bvmgZVQIju9j56gUWseuLMq6FxO3EnIUskyLENka1da67Y00byFOO/sdcoQLbV
         OsGpk5ivGcWH3N4KuUPDJ1vlih5OFr9IZ2MiXhDNnGabKMtmc9+HWXVuCFhtNyDdHsWj
         mH3BBDgIgdiDTO+6ikHyufm6LTm9+ZPo2TTZw=
Received: by 10.223.58.20 with SMTP id e20mr51942fah.96.1269561443613;
        Thu, 25 Mar 2010 16:57:23 -0700 (PDT)
Received: from localhost.localdomain (abvh236.neoplus.adsl.tpnet.pl [83.8.205.236])
        by mx.google.com with ESMTPS id d13sm592053fka.2.2010.03.25.16.57.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 16:57:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2PNuggw030732;
	Fri, 26 Mar 2010 00:56:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2PNuMbJ030569;
	Fri, 26 Mar 2010 00:56:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.1003251459540.694@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143202>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 25 Mar 2010, Mike.lifeguard wrote:
> 
> > On 10-03-25 01:39 AM, Theodore Tso wrote:
> > > How do you know whether said contributor
> > > isn't a Chinese intelligence agent trying to insert a backdoor into
> > > your program
> > 
> > Because they are only contributing translations.
> 
> Just take over authorship of the patch yourself then.
> 
> Or pick a generic email address such as the translator's mailing list 
> email address or the like.

In the case of translations one cal use generic "language team"
mailing list, i.e. <LL@li.org> (where LL is ISO code of language,
e.g. 'de@li.org' for translations to German, etc.).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
