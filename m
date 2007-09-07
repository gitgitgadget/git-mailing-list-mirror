From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 7 Sep 2007 13:36:51 +0200
Message-ID: <308098E9-CCAF-44F1-9FEF-F3933218401E@wincent.com>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:37:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITc98-0000jy-8N
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbXIGLhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 07:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbXIGLhE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:37:04 -0400
Received: from wincent.com ([72.3.236.74]:48475 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965178AbXIGLhD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 07:37:03 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l87BavCu031121;
	Fri, 7 Sep 2007 06:36:58 -0500
In-Reply-To: <85k5r27wkv.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58028>

El 7/9/2007, a las 9:40, David Kastrup escribi=F3:

> A design is perfect not when there is no longer anything you can add
> to it, but if there is no longer anything you can take away.

Il semble que la perfection soit atteinte non quand il n'y a plus =20
rien =E0 ajouter, mais quand il n'y a plus rien =E0 retrancher.
Perfection is achieved, not when there is nothing more to add, but =20
when there is nothing left to take away.
Ch. III: L'Avion, p. 60

<http://en.wikiquote.org/wiki/Exupery>
