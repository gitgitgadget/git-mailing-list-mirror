From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 10:57:57 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1101261056570.5603@tvnag.unkk.fr>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com> <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com> <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
 <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mika Fischer <mika.a.fischer@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 11:04:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi2Ed-0003eo-Fq
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 11:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab1AZKEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 05:04:09 -0500
Received: from giant.haxx.se ([80.67.6.50]:43523 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557Ab1AZKEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 05:04:08 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2011 05:04:07 EST
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9.1) with ESMTP id p0Q9vv8n026065;
	Wed, 26 Jan 2011 10:57:57 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165512>

On Wed, 26 Jan 2011, Mika Fischer wrote:

>> I'll see if I can get a more current version of curl to compile under 
>> Windows.
>
> I did not manage to do do this.
>
> But I noticed that the same problem occurs on OpenSuSE 11.2. So I compiled 
> the latest version of curl on OpenSuSE 11.2 and the problem is still 
> present...

Are these clean builds of libcurl and OpenSSL from source?

I'll try to look into this.

-- 

  / daniel.haxx.se
