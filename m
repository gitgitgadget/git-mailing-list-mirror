From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix to output file names
Date: Wed, 10 Jun 2009 12:51:09 +0200
Organization: At home
Message-ID: <h0o36t$7it$1@ger.gmane.org>
References: <4A2E576D.704@op5.se> <1244629715-30444-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 12:51:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MELP3-00026K-7V
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 12:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbZFJKvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZFJKvX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 06:51:23 -0400
Received: from main.gmane.org ([80.91.229.2]:60673 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbZFJKvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 06:51:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MELOp-0006Pw-Un
	for git@vger.kernel.org; Wed, 10 Jun 2009 10:51:19 +0000
Received: from abvn21.neoplus.adsl.tpnet.pl ([83.8.211.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 10:51:19 +0000
Received: from jnareb by abvn21.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 10:51:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvn21.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121271>

Nguy?n Th=E1i Ng?c Duy wrote:

> +--filename-prefix=3D.<pfx>::
> +=A0=A0=A0=A0=A0=A0=A0Prepend specified prefix in front of generated =
filenames.
> +
> =A0--suffix=3D.<sfx>::
> =A0=A0=A0=A0=A0=A0=A0=A0Instead of using `.patch` as the suffix for g=
enerated
> =A0=A0=A0=A0=A0=A0=A0=A0filenames, use specified suffix. =A0A common =
alternative is

I think it should be

   --filename-prefix=3D<pfx>::

(without the dot '.').
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
