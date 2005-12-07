From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: Wine + GIT
Date: Wed, 7 Dec 2005 11:56:16 +1100
Message-ID: <E6BEDA9B-561F-4D25-8406-77B688B66546@hawaga.org.uk>
References: <20051206173909.GE17457@fieldses.org> <1133891589.8577.63.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 02:01:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejndo-00050H-PN
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVLGA6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Dec 2005 19:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVLGA6i
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:58:38 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:8458 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S964974AbVLGA6h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 19:58:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jB70vaT9011521;
	Wed, 7 Dec 2005 00:57:38 GMT
In-Reply-To: <1133891589.8577.63.camel@cashmere.sps.mot.com>
To: Jon Loeliger <jdl@freescale.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13314>


On 7 Dec 2005, at 04:53, Jon Loeliger wrote:

> On Tue, 2005-12-06 at 11:39, J. Bruce Fields wrote:
>
>> I've enjoyed getting tab completions without having to add whatever'=
s
>> required to my .bashrc to teach it about git subcommands.  Oh well,
>> I'll
>> get over it.
>
> I believe this effort is already well under way.
> Uh, I also thought we were going to place it in
> some "contrib" directory too...?
>

The (latest as of now) code for cogito is in cogito's contrib/ =20
directory.

You can get stg,cogito,git,gitk completion code from my repo with:

  cg clone http://www.hawaga.org.uk/gitcompletion.git

(I posted a note about it the other day on this git list, entitled =20
'bash completions code for git+porcelain)


--=20
Ben =E2=80=A2 =E3=83=99=E3=83=B3 =E2=80=A2 =D0=91=D1=8D=D0=BD =E2=80=A2=
 =EB=B2=A4 =E2=80=A2 =E7=8F=AD=E6=98=8E
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
