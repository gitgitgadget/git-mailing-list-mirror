From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 09:18:59 -0800
Message-ID: <AANLkTi=3Z5Wnh_s3S10fDn26dypbt9aG93nOKan_8c4d@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com> <4D3077FE.9090407@spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, JT Olds <jtolds@xnet5.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jan 14 18:20:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdnJd-00022M-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 18:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651Ab1ANRTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 12:19:53 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36682 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757532Ab1ANRTv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 12:19:51 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0EHJKbb026895
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 14 Jan 2011 09:19:21 -0800
Received: by iyj18 with SMTP id 18so2694099iyj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 09:19:19 -0800 (PST)
Received: by 10.231.35.204 with SMTP id q12mr933770ibd.191.1295025559210; Fri,
 14 Jan 2011 09:19:19 -0800 (PST)
Received: by 10.231.31.72 with HTTP; Fri, 14 Jan 2011 09:18:59 -0800 (PST)
In-Reply-To: <4D3077FE.9090407@spacetec.no>
X-Spam-Status: No, hits=-2.378 required=5 tests=AWL,BAYES_05
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165114>

On Fri, Jan 14, 2011 at 8:21 AM, Tor Arntsen <tor@spacetec.no> wrote:
> On 14/01/2011 17:13, Erik Faye-Lund wrote:
>
>> I think Tor pointed out that he knew a swede with his full legal name
>> to be only one letter long. I would suppose that meant that he didn't
>> have a surename?
>
> Exactly. He didn't. Bank printouts etc. would only have that single
> letter, he didn't use a nickname - that letter was his legal name.
>
> As for the rest of the world - I don't think the first name/last name combo
> (almost) everyone in the west use is necessarily a universal rule.

Quite frankly, I'd suggest that person then use "The letter 'G'" as
his/her git name.

git names aren't "legal names". They are for informational purposes.

And a single letter just isn't informational.

                Linus
