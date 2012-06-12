From: konglu@minatec.inpg.fr
Subject: Re: [PATCH 5/6] Tests of UTF8 character with git-remote-mediawiki
Date: Tue, 12 Jun 2012 23:45:18 +0200
Message-ID: <20120612234518.Horde.MC1TTXwdC4BP17hurbfVZrA@webmail.minatec.grenoble-inp.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
 <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr>
 <1339535563-18958-5-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYuR-000480-L5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab2FLVpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 17:45:24 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:36236 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751250Ab2FLVpX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 17:45:23 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 5A62E1A0259;
	Tue, 12 Jun 2012 23:45:19 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Tue, 12 Jun
 2012 23:45:18 +0200
In-Reply-To: <1339535563-18958-5-git-send-email-simon.cathebras@ensimag.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199866>


Simon Cathebras <simon.cathebras@ensimag.imag.fr> a =C3=A9crit=C2=A0:

> This patch provides a sample of tests for git-remote-mediawiki's
> resistance, concerning utf8 special characters.
>
> Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
> Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
> Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
> Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
> Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
> ---
>  contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh | 271 =20
> ++++++++++++++++++++++++++++
>  1 file changed, 271 insertions(+)
>  create mode 100755 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh

Thanks, it applies correctly now :)
