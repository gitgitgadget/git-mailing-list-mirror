From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 5/6] Tests of UTF8 character with git-remote-mediawiki
Date: Wed, 13 Jun 2012 09:30:49 +0200
Message-ID: <4FD841A9.2010507@ensimag.imag.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr> <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339535563-18958-5-git-send-email-simon.cathebras@ensimag.imag.fr> <4FD7B242.9020005@ensimag.imag.fr> <20120612235214.Horde.b7SrP3wdC4BP17oOhzt0vgA@webmail.minatec.grenoble-inp.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Wed Jun 13 09:31:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sei2f-0003J3-UO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 09:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab2FMHa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 03:30:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52108 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab2FMHa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 03:30:56 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5D7Lokc018395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2012 09:21:50 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5D7UmBw008152;
	Wed, 13 Jun 2012 09:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120612235214.Horde.b7SrP3wdC4BP17oOhzt0vgA@webmail.minatec.grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Jun 2012 09:21:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5D7Lokc018395
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340176911.19633@S5938OYByLZXCXP7SmYrGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199876>



On 12/06/2012 23:52, konglu@minatec.inpg.fr wrote:
>
> "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> a =C3=A9crit :
>
>> Please accept our appologize for the bad tag for patches.
>>
>> The PATCH 5 is actually the last one...
>
> Shouldn't it also be the version 4 ?
>

Actually, yes.
Thanks.

> Thanks,
>
> Lucien Kong
>


--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=C3=A8re Ing=C3=A9ni=C3=A9rie des Syst=C3=A8mes d'Information
Membre Bug-Buster
