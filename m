From: Marcin Cieslak <saper@saper.info>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sat, 28 Aug 2010 22:30:14 +0000
Message-ID: <alpine.BSF.2.00.1008282229460.67930@x.fncre.vasb>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com> <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com> <20100828214641.GA5515@burratino> <20100828215956.GB5515@burratino> <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
 <20100828222031.GC5777@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 00:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpTuq-0000cQ-6C
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 00:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab0H1WaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 18:30:18 -0400
Received: from k.saper.info ([91.121.151.35]:26590 "EHLO k.saper.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab0H1WaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 18:30:17 -0400
X-Greylist: delayed 938 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Aug 2010 18:30:16 EDT
Received: from k.saper.info (localhost [127.0.0.1])
	by k.saper.info (8.14.4/8.14.4) with ESMTP id o7SMUEEB069244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Aug 2010 22:30:14 GMT
	(envelope-from saper@saper.info)
Received: from localhost (saper@localhost)
	by k.saper.info (8.14.4/8.14.4/Submit) with ESMTP id o7SMUELW069241;
	Sat, 28 Aug 2010 22:30:14 GMT
	(envelope-from saper@saper.info)
X-Authentication-Warning: k.saper.info: saper owned process doing -bs
In-Reply-To: <20100828222031.GC5777@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154664>

On Sat, 28 Aug 2010, Jonathan Nieder wrote:

> Marcin Cieslak wrote:
>
>> What's wrong?
>
> http://sourceware.org/bugzilla/show_bug.cgi?id=6530

Yes, a pretty old SPARC Solaris box gives me the same result
as FreeBSD.

--Marcin
