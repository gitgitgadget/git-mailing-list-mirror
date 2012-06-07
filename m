From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv2] rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 14:04:04 +0200
Message-ID: <20120607140404.Horde.hAwfKHwdC4BP0Ji0lAVB6zA@webmail.minatec.grenoble-inp.fr>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD06906.1080007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 14:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbRp-0004ZJ-3a
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab2FGMEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 08:04:09 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:48538 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772Ab2FGMEH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 08:04:07 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id F23B71A0300;
	Thu,  7 Jun 2012 14:04:04 +0200 (CEST)
Received: from wifi-028144.grenet.fr (wifi-028144.grenet.fr
 [130.190.28.144]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Thu, 07 Jun 2012 14:04:04 +0200
In-Reply-To: <4FD06906.1080007@kdbg.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199394>


Johannes Sixt <j6t@kdbg.org> a =E9crit=A0:

> BTW, I don't think it is a good idea to dump the usage if -x was used
> without -i.

In fact, that would be the next step, so that the "--exec" option could
be used without the interactive mode.
