From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv3 1/2] git-rebase.txt: "--onto" option updated
Date: Fri, 08 Jun 2012 22:08:35 +0200
Message-ID: <20120608220835.Horde.eP-uRXwdC4BP0lvDP2D2BYA@webmail.minatec.grenoble-inp.fr>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vipf1d96k.fsf@alter.siamese.dyndns.org>
 <20120608210630.Horde.joXbQHwdC4BP0k02QgDFpMA@webmail.minatec.grenoble-inp.fr>
 <7v8vfxd1j3.fsf@alter.siamese.dyndns.org>
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
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 22:08:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5UB-0001n0-R2
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 22:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759009Ab2FHUIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 16:08:40 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:59889 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758669Ab2FHUIj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 16:08:39 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id CF39A1A030B;
	Fri,  8 Jun 2012 22:08:35 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 22:08:35 +0200
In-Reply-To: <7v8vfxd1j3.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199527>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> konglu@minatec.inpg.fr writes:
>
>> That's what I thought, but it appeared to me that the description
>>
>> --onto <newbase>::
>>          Starting point at which to create the new commits.
>>          If the --onto option is not specified, the starting
>>          point is <upstream>.  May be any valid commit, and
>> 	not just an existing branch name.
>>
>> only focus on the parameter <newbase>.
>
> Talking about <newbase> is equivalent to talking about --onto isn't
> it?  What the command does is described far above upfront in the
> manual page; the description of options is the place to explain what
> details are affected by giving (or not giving) the option in the
> behaviour that was explained earlier.

Alright, gonna keep it unchanged then :).
