From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] URL rewrite in .gitmodules
Date: Mon, 26 Oct 2015 17:52:01 +0100
Message-ID: <562E5A31.7050903@web.de>
References: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com>
 <xmqqio618mxc.fsf@gitster.mtv.corp.google.com>
 <F01EF930-9787-44DD-A2E5-F5FBA029D3E7@gmail.com>
 <CAGZ79kbFDB55mKnw-ONPGBmHfeXZDBKOb=HrjjepiBh3kgcO1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 17:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zql0d-0007tS-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 17:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbJZQwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 12:52:12 -0400
Received: from mout.web.de ([212.227.15.14]:61698 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbbJZQwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 12:52:11 -0400
Received: from [192.168.178.41] ([79.211.105.62]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LgHau-1aKc9y3dPY-00nfPB; Mon, 26 Oct 2015 17:52:07
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbFDB55mKnw-ONPGBmHfeXZDBKOb=HrjjepiBh3kgcO1g@mail.gmail.com>
X-Provags-ID: V03:K0:5F9PRqrFslcFfC1KXhIaimhojcZF/FNsbtp1Uj5cOQCMlb71yEp
 3xXBsA0Kspw4vEMu7ERfOfOfDNaFcml0Of4u15ZCyaMFb+2DsBHecmUJjVQxJPLamFeDu3t
 MYyRa1V/t/s7k/HOMJCiYm7h4lIQtT+1j5XbR8M6FpHWXm2TgpMFgxUtv0uxg5xzT3OicFm
 9A5byOinY5lBex7Q8or6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mjjTLBEznbo=:wSq9YIn9zElwtiMA3Sti/Q
 im6cOV7lG+N9Erw9CVnmtr/GDGpD7GleoJ4vHcqpmo2BBrKyRBIPNeRj87Z8BJyiOXDTimVTH
 KUhWgljaqshfK1RLjwUGo56FKwthgRoKNPs4nrMPiuBrtNItbN65EWaXsTJeKMZTrTJM1Np/9
 3icYR9t0XYt8HlZ1B06tSm/a/5Lbtl5b1fsDuC1R+4z6oMRM7v6mp/VG76ysmdg5BxH/WWfOU
 oEAJPNwW1dThN2tjKzT3yIdM/oMKKQ7EmAMSugPpGe1wDuBohcLrCcOn4Y6oYrZW1jRFLbI/p
 VFH5+KOe0QcIFsrBO0yz4+6hQvoJPHZIQ8ANsUiscg4xp+eUJbbzizt6FupCzK9QG808jxz6E
 9oLtkGp4OVKx54ex+T8wn7umBx5z6WKNXHo5IJPRLm95tna+UivwyBVY1KbfoIBqIC5HsZnSm
 d0yjJ6cjSCa0ZAKZUbmSheQ+zcDEZu+cVL8Ab4ZRjLDobkw+ugzZZFIWtlfFKnbQRq/CUKO0b
 EgaBmaOinnL4urB9hbYAVxg1liZvOAh1pmpPnV23YjnN0/QgaDAFSxODv16Xr2/WsmRHW3gvS
 I2CkIsqiHGi+1N+w112EgZwZjQl7TSmFtY7KY18909DN3MwAKA1JWRQYkhXDXxAYLE3ieMFjO
 IOfDCvxiqsAuGe0zv9VjxVZHpvua1zFCz5eCbmACigzVZabkEJR/0MOOzEcTQAKSpA9JWzQBV
 vMUaQSTPDtZ6y/zaS4NgElfXTqa3EoH681J3QeEbCIHEK0jxDcmJbMWFc/JedEZxehKoVs3o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280200>

Am 26.10.2015 um 17:34 schrieb Stefan Beller:
> On Sun, Oct 25, 2015 at 8:12 AM, Lars Schneider <larsxschneider@gmail.com> wrote:
>> On 20 Oct 2015, at 19:33, Junio C Hamano <gitster@pobox.com> wrote:
>>> I do not think this topic is specific to use of submodules.  If you
>>> want to encourage your engineers to fetch from nearby mirrors you
>>> maintain, you would want a forest of url.mine.insteadof=theirs for
>>> the external repositories that matter to you specified by
>>> everybody's $HOME/.gitconfig, and one way to do so would be to have
>>> them use the configuration inclusion.  An item in your engineer
>>> orientation material could tell them to add
>>>
>>>        [include]
>>>                path = /usr/local/etc/git/mycompany.urlrewrite
>>>
>>> when they set up their "[user] name/email" in there.
>>>
>>> And you can update /usr/local/etc/git/mycompany.urlrewrite as
>>> needed.
>> Oh nice, I didn't know about "include". However, as mentioned to Stefan in this thread, I fear that our engineers will miss that. I would prefer a solution that does not need any additional setup. Therefore the suggestion to add rewrites in the .gitmodules file.
>
> How do you distribute new copies of Git to your engineers?
> Maybe you could ship them a version which has the "include" line
> already builtin as default? So your distributed copy of Git
> would not just check the default places for configs, but also
> some complied in /net/share/mycompany.gitconfig

Which is just what we do at $DAYJOB, that way you can easily
distribute all kinds of settings, customizations and hooks
company-wide.
