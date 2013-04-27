From: Johannes Schneider <mailings@cedarsoft.com>
Subject: Re: Making a (quick) commit to another branch
Date: Sat, 27 Apr 2013 23:06:26 +0200
Message-ID: <517C3DD2.5090007@cedarsoft.com>
References: <517BDB6D.8040809@cedarsoft.com> <CALZVap=9Z=0DPM1fNwotn3sN-W7mXMPRSJ2aY5jzkQTBD6v=Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWCKT-0007Zn-LN
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab3D0VGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:06:31 -0400
Received: from hosting.cedarsoft.com ([176.9.39.58]:45242 "EHLO
	mail.cedarsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab3D0VGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:06:30 -0400
Received: from [192.168.0.81] (HSI-KBW-149-172-123-74.hsi13.kabel-badenwuerttemberg.de [149.172.123.74])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.cedarsoft.com (Postfix) with ESMTPSA id A4AFE1E0349;
	Sat, 27 Apr 2013 23:06:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALZVap=9Z=0DPM1fNwotn3sN-W7mXMPRSJ2aY5jzkQTBD6v=Kw@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222698>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27.04.2013 16:21, Javier Domingo wrote:
> I would first recommend you, instead of cherry-picking the commit,
> you did this: -- stash -- go to the master branch -- fix the line 
> -- commit the fix -- got to the feature branch -- unstash

Yeah, of course u are right.

Thanks for pointing that out - saves me a few key strokes.






> As when you merge with master, git will carry on with the changes.
> I don't see the need to cherry pick that commit.
> 
> Javier Domingo
> 

- -- 
Johannes Schneider - blog.cedarsoft.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJRfD3SAAoJEAytD9R7Qv6duWgH/2BIIuTP0FJTR9Duli+jyzd4
dIicrkwuCCELiOe3XQ2vSgxxr0nUI52Vn0uCRaXwXJqz466/55PGvpNb/COnLUm0
sSDXbQFVPZtb38AZIQvz844pzb5R9DMujp5g/3oA146x7LscPvrWmtSCK6mlGDa5
bm9LUdULP9eMEJ1aJaqDYEDQ/vY/rS/66/c7G2+A1EysxIlW3t3aXLSosv/BGjbF
l2RyHFeV0RsreeA+Aa1ZJoyheMqkDCVKijo/xfBnz7m9OFj12g1moSheD7p2hDJh
UHQU4d9qrHmFcUAhkMe9wIP8Opr98Q7GZOq03p5DaWzWggV2HPcrP8rkmARx2Q8=
=9I4w
-----END PGP SIGNATURE-----
