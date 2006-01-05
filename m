From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: trivial: .gitignore precompiled pyhton modules
Date: Thu, 5 Jan 2006 17:38:58 +0100
Message-ID: <81b0412b0601050838y6bb30985i9989df58222bc86c@mail.gmail.com>
References: <81b0412b0601050358q6163ef1bqa8696d5881feb657@mail.gmail.com>
	 <Pine.LNX.4.63.0601050944200.667@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14302_33472894.1136479138316"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 17:39:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuY8p-00025A-EE
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 17:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWAEQjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 11:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWAEQjE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 11:39:04 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:33620 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751097AbWAEQjB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 11:39:01 -0500
Received: by nproxy.gmail.com with SMTP id x37so141522nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 08:38:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=smKMr+kzVmplGkjNR9Ug1Dqv0prGiQVLEl9WGpZJVpxniRh9RD1AePRlfxMmHO5ZRHMPPCnWFwCXxP8mjXFsugiAtZCYXL8ILh3QSAGIvEEoSE/K4Mz9OkqrSfmNiKQDugiBibicygO7tuVPjvYno0OgxarBdJVzMf4IGQyq6Ic=
Received: by 10.48.255.7 with SMTP id c7mr700927nfi;
        Thu, 05 Jan 2006 08:38:58 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 08:38:58 -0800 (PST)
To: Jon Nelson <jnelson-git@jamponi.net>
In-Reply-To: <Pine.LNX.4.63.0601050944200.667@gheavc.wnzcbav.cig>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14202>

------=_Part_14302_33472894.1136479138316
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/5/06, Jon Nelson <jnelson-git@jamponi.net> wrote:
>
> Don't forget about .pyo
> You also spelled python as 'pyhton'

Hmm, I don't get any of these...
And sorry for the typo, didn't mean no offence :)

For the record, the patch extended and attached.

------=_Part_14302_33472894.1136479138316
Content-Type: text/plain; name="0001-ignore-precompiled-python-modules.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-ignore-precompiled-python-modules.txt"

U3ViamVjdDogW1BBVENIXSBpZ25vcmUgcHJlY29tcGlsZWQgcHl0aG9uIG1vZHVsZXMKClNpZ25l
ZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+CgoKLS0tCgogLmdpdGln
bm9yZSB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCgpiMjUwZGE4NDhkNjdmYWRlNzRiMTM5MjJhNDZkYmMyOGRlN2QyODkyCmRpZmYgLS1n
aXQgYS8uZ2l0aWdub3JlIGIvLmdpdGlnbm9yZQppbmRleCA0N2Q3NmY0Li4xYTkwOTBiIDEwMDY0
NAotLS0gYS8uZ2l0aWdub3JlCisrKyBiLy5naXRpZ25vcmUKQEAgLTEyMCwzICsxMjAsNCBAQCBn
aXQtY29yZS5zcGVjCiAqLmV4ZQogbGliZ2l0LmEKICoubworKi5weVtjb10KLS0gCjEuMC42LWdk
NGFiCg==
------=_Part_14302_33472894.1136479138316--
