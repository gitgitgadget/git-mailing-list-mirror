From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] What is a tag for?
Date: Tue, 17 Jan 2006 20:00:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601171949430.3240@g5.osdl.org>
References: <1137538344.9104.34.camel@malory> <7v1wz648jc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 05:00:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ez4Us-0005op-4c
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 05:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWAREAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 23:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWAREAb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 23:00:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964906AbWAREAb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 23:00:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0I40QDZ008131
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Jan 2006 20:00:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0I40Mfk017215;
	Tue, 17 Jan 2006 20:00:23 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wz648jc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14811>



On Tue, 17 Jan 2006, Junio C Hamano wrote:
> 
> <offtopic>
> Does anybody know where to obtain the public key to verify
> v2.6.16-rc1 tag?
> </offtopic>

Do a google search for "torvalds" and "tag signing key", and you'll find 
the thread that has the original key in it.

In fact, if you search for "torvalds" "tag" and "BEGIN PGP PUBLIC KEY 
BLOCK", it will be the first hit.

Anyway, here it is again. Linus' tag signing key. I could do what you do, 
but I feel that it's kind of pointless to put the public key with the 
project, since if you don't trust the project, you shouldn't trust the key 
it contains as being from me.

You fundamentally want to have some _other_ reason to trust the key, like 
the fact that you can find it independently with google ;)

		Linus

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.1 (GNU/Linux)

mQGiBEJqZ4sRBADKttqQOCAxRzz5qGmo5QnSR5GTkSlPTm4lCuaVUon0qQPNrasr
cSBAOJ1MlXjhbRPrN3pAhI+taLgrWQ231zUNHxCTmWJZV3Yzxr8xJQGlfHlVOxXB
LI42tAfCjHOF7z8pPj6AGhtE2+fzq1U3mOlA/fUG4uYDOwIoPK+qgbM6SwCgulqs
DGlQKFFtFgW8HVnDftFmyZMD+wc0E9jRa9HJ3b1U3vY1jrxpoVw5QeeIZdSRnRFy
sknOHca5mlJvTidu1cs7xCuvpufw1VIVvgf4tPwXcTDEKthYEhoty+DFOqZ9R7pg
EMhjYbq+Q8yLT3OWQtUKV4B10FRYIWidnJ8y2CjLduTmB+cyj976oxEY/llLBbQM
yuDrBADDLw/3KZL5D75icA0l/uebQ6/73j8jcRoVu0gTqAdQBYL6Zv7Y0G7xHUCo
Eqgo+p2LXAeU9IoeA5/h8SNVDw4fYoqo6VQTkr+ydegHkjwlbrhOL/gxzlY1Pde1
TBi6+QCUssk0FCPMALt7M+OgFpSKx7pP2xSsDsMvvNNAmLl0JrQ0TGludXMgVG9y
dmFsZHMgKHRhZyBzaWduaW5nIGtleSkgPHRvcnZhbGRzQG9zZGwub3JnPoheBBMR
AgAeBQJCameLAhsDBgsJCAcDAgMVAgMDFgIBAh4BAheAAAoJEBd2LEZ24hy7I84A
nROHRYes4RU8btdleR0TgwJG7jMvAKCF2CingjxaC4sTL7BkFfNacTkBYLkBDQRC
ameMEAQAlJiw0IBltu5ihEXE4mFYiWHuVAoeufVJ9fONv67y6fu3efJ10PJ7AQdG
Ufez+8yxkrahyIVC77NuQLDrRfvgmrJ8sbP8xb6QEbY1bnwLeuciTolGjL+kYi17
J74iG2cQDyimnLWJm5lNqeUOz3nTW429SyLCRhXpR1lUjijiVi8AAwcD/1f4VEql
u9HHTA4S+1aoOQV5guZCr6JbYdWkAZeeFRpFSXfCae6uO8DhpD7o/8kiK3O8qP1O
yjQF0bG26iLCm8MdJCO0WQ2xsVlwrrvnNPpgRgbirOgoxHM4ESq/YV+MqXo41Hm0
ilHRM7OIbmm7uvFSlUJmUasuJRsrhibilbvNiEkEGBECAAkFAkJqZ4wCGwwACgkQ
F3YsRnbiHLsolQCfRVImDkgijhPGmwyI7T19bWltXwsAniMi9gakkN+9DT8E5kli
e8uTEk8f
=PRrZ
-----END PGP PUBLIC KEY BLOCK-----
