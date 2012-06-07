From: konglu@minatec.inpg.fr
Subject: Re: commit a63d7ed3017e312ddc752ac89a7d292a745d5f11 broken on MacOS
Date: Thu, 07 Jun 2012 18:40:11 +0200
Message-ID: <20120607184011.Horde._TrvenwdC4BP0Nlr034iWHA@webmail.minatec.grenoble-inp.fr>
References: <4FD0964E.7040302@web.de>
 <20120607162032.Horde.3lGNYXwdC4BP0LiwzlCRupA@webmail.minatec.grenoble-inp.fr>
 <4FD0D375.9060902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Torsten =?iso-8859-1?b?QvZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 07 18:40:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScflT-00074y-VK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab2FGQkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 12:40:36 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:59953 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753453Ab2FGQkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 12:40:16 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 506A01A0304;
	Thu,  7 Jun 2012 18:40:12 +0200 (CEST)
Received: from wifi-028144.grenet.fr (wifi-028144.grenet.fr
 [130.190.28.144]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Thu, 07 Jun 2012 18:40:11 +0200
In-Reply-To: <4FD0D375.9060902@web.de>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199415>


Torsten B=F6gershausen <tboegi@web.de> a =E9crit=A0:

> On 07.06.12 16:20, konglu@minatec.inpg.fr wrote:
>> Does it work if the whitespaces are deleted so that it becomes
>> /^pick .*/i\exec gi..." ? (see the patch corrected below).
>
>
> I didn't manage to appy the patch, either
> fatal: corrupt patch at line 14
> or, if I remove that line
> line 14 is bad, or there is no email address.
>
> Does the patch apply on your system ?
> /Torsten

Sorry, doesn't work on mine too. Gonna send a proper patch.

Lucien Kong
