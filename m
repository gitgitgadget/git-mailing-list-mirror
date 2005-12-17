From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: [PATCH] cg-completion: improve options and command listing
Date: Sun, 18 Dec 2005 08:55:00 +0930
Message-ID: <EF827EE8-7B7A-4D19-A08D-8C67D6B74195@hawaga.org.uk>
References: <20051211190931.GF2960@diku.dk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Dec 18 01:45:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnmdN-0000nf-G4
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 01:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVLRAmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Dec 2005 19:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVLRAmh
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 19:42:37 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:32785 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S932264AbVLRAmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2005 19:42:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jBI0c2MX020464;
	Sun, 18 Dec 2005 00:41:03 GMT
In-Reply-To: <20051211190931.GF2960@diku.dk>
To: Jonas Fonseca <fonseca@diku.dk>
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13783>


On 12 Dec 2005, at 04:39, Jonas Fonseca wrote:

> Complete help options and improve filtering for command name =20
> completion.
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>

Hi. I've applied this patch to the dev branch cg-compl in my =20
gitcompletion repo.

I'm interested by what you mean by 'all sorts of garbage' - it seems =20
ok on my machine.

Ben


> ---
>
>  The current filtering causes all sorts of garbage to be listed in th=
e
>  command listing.
>
> commit f0535e9952f1cace89d03649e8238aca69a6df44
> tree e05dfadb63bd92ead0dc29d326065b7a797e2109
> parent 3c14cded46e110396127fc5b5e65883eb5cd60b9
> author Jonas Fonseca <fonseca@diku.dk> Wed, 07 Dec 2005 20:58:50 +010=
0
> committer Jonas Fonseca <fonseca@antimatter.localdomain> Wed, 07 =20
> Dec 2005 20:58:50 +0100



--=20
Ben =E2=80=A2 =E3=83=99=E3=83=B3 =E2=80=A2 =D0=91=D1=8D=D0=BD =E2=80=A2=
 =EB=B2=A4 =E2=80=A2 =E7=8F=AD=E6=98=8E
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
