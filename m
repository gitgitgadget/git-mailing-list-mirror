From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Sat, 09 Jun 2012 08:47:07 +0200
Message-ID: <20120609084707.Horde.CGejZXwdC4BP0vFrryT2xDA@webmail.minatec.grenoble-inp.fr>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD24AE9.8020101@web.de>
 <20120608211540.Horde.SRiCRHwdC4BP0k9c5TdWBaA@webmail.minatec.grenoble-inp.fr>
 <4FD258AD.6070601@web.de>
 <20120608220751.Horde.HHn7fXwdC4BP0luXQhxWxBA@webmail.minatec.grenoble-inp.fr>
 <4FD265C7.6050807@web.de>
 <20120608230327.Horde.IXfFTHwdC4BP0mifi63m9KA@webmail.minatec.grenoble-inp.fr>
 <4FD2E9B5.1010709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Torsten =?iso-8859-1?b?QvZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 09 08:56:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdFbB-0001qj-CD
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 08:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab2FIGzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 02:55:50 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:45461 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091Ab2FIGzu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 02:55:50 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id EBEAE1A1206;
	Sat,  9 Jun 2012 08:47:07 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sat, 09 Jun
 2012 08:47:07 +0200
In-Reply-To: <4FD2E9B5.1010709@web.de>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199546>


Torsten B=F6gershausen <tboegi@web.de> a =E9crit=A0:

> Hej,
> I have 2 patches with the headline "[PATCHv3 1/2" in my in box.
> None of them is dealing in any kind with upgrading a command to =20
> understand "exec".

Here you can see the thread of the discussion:

http://thread.gmane.org/gmane.comp.version-control.git/199497

> To be able to test under Mac OS it could be helpful if you just re-se=
nd
> one patch to my email.
> Then I can try to re-do the patch based on f623ca1cae600e97cb0b38 and
> test it under Mac OS.

Alright, gonna send you the patch in one part so that it can be applied
alone :).

Lucien Kong
