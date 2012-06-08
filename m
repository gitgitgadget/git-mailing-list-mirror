From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv6 2/4] Let core.excludesfile default to
 $XDG_CONFIG_HOME/git/ignore
Date: Fri, 08 Jun 2012 11:02:38 +0200
Message-ID: <20120608110238.Horde.s0zeY3wdC4BP0b_uCZzlJ3A@webmail.minatec.grenoble-inp.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-2-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vk3ziem2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 11:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scv5h-0006xK-PY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 11:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934008Ab2FHJCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 05:02:41 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:47694 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933075Ab2FHJCk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 05:02:40 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 561371A02F1;
	Fri,  8 Jun 2012 11:02:38 +0200 (CEST)
Received: from wifi-028244.grenet.fr (wifi-028244.grenet.fr
 [130.190.28.244]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Fri, 08 Jun 2012 11:02:38 +0200
In-Reply-To: <7vk3ziem2n.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199473>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> But that may not be what you meant to say.  I dunno.

It is exactly what we want to do. It is true the statement was very =20
short and we didn't state what problem we are trying to solve. Your =20
points raise the issues and explain clearly our solution.
