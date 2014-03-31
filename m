From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Bug report: git add . -p "Argument list too long"
Date: Mon, 31 Mar 2014 22:38:26 +0100
Organization: OPDS
Message-ID: <451827DDA9B84629BB261BE933029561@PhilipOakley>
References: <2893758C-2196-4A0F-8FD7-69C13B1EDBA4@komendera.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Dieter Komendera" <dieter@komendera.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:38:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjut-0000ph-P8
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbaCaVin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2014 17:38:43 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:23387 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750857AbaCaVim (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 17:38:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhUZABDgOVNZ8Y87/2dsb2JhbABZgwY7iR+6ZgEBAgEBgSMXdIIgBQEBAQECAQgBASgBBR4BARYGCgYBAQMFAgEDEQQBAQolFAEEGgYHDwgGARIIAgECAwGHYAwJtCadIY8Mgx6BFASPPopDkQKDMTw
X-IPAS-Result: AhUZABDgOVNZ8Y87/2dsb2JhbABZgwY7iR+6ZgEBAgEBgSMXdIIgBQEBAQECAQgBASgBBR4BARYGCgYBAQMFAgEDEQQBAQolFAEEGgYHDwgGARIIAgECAwGHYAwJtCadIY8Mgx6BFASPPopDkQKDMTw
X-IronPort-AV: E=Sophos;i="4.97,767,1389744000"; 
   d="scan'208";a="606586678"
Received: from host-89-241-143-59.as13285.net (HELO PhilipOakley) ([89.241.143.59])
  by out1.ip06ir2.opaltelecom.net with SMTP; 31 Mar 2014 22:38:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245537>

----- Original Message -----=20
=46rom: "Dieter Komendera" <dieter@komendera.com>
To: <git@vger.kernel.org>
Sent: Monday, March 31, 2014 10:04 PM
Subject: Bug report: git add . -p "Argument list too long"


> Hi there,
>
> since a while when I want to stage diffs in one of my big repos with=20
> "git add . -p=94 I get this error:
>
> Can't exec "git": Argument list too long at=20
> /usr/local/Cellar/git/1.9.1/libexec/git-core/git-add--interactive lin=
e=20
> 180.
> Died at=20
> /usr/local/Cellar/git/1.9.1/libexec/git-core/git-add--interactive lin=
e=20
> 180.
>
> Mac OS X 10.9.2
> git 1.9.1 (installed via homebrew)
>
> I=92ve also tried the latest versions of the 1.7 and 1.8 branches whi=
ch=20
> also yielded the same error in that repo.
> git add . -p works fine in other (smaller) repos. Unfortunately I=92m=
=20
> not able to share this private repo.
>
> I found this rather old posting in the mailing list archive,=20
> unfortunately the link to the "quick and easy fix=94 looks dead:
> http://article.gmane.org/gmane.comp.version-control.git/142863/match=3D=
argument+list+too+long+git+add
>
> Anybody can help?
>
> Thanks,
> Dieter
>
http://article.gmane.org/gmane.comp.version-control.git/136157 maybe?=20
