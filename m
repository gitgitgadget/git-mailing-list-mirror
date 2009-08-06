From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: msysGit and SCons: broken?
Date: Thu, 06 Aug 2009 21:45:46 +0200
Message-ID: <4A7B32EA.2080505@dirk.my1.cc>
References: <4A772A43.8070503@dirk.my1.cc> <alpine.DEB.1.00.0908040010220.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8uU-0007mo-1O
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbZHFTpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756224AbZHFTpu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:45:50 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:34679 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686AbZHFTpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:45:49 -0400
Received: from [84.176.71.177] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MZ8uK-0000F3-Ad; Thu, 06 Aug 2009 21:45:48 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.DEB.1.00.0908040010220.8306@pacific.mpi-cbg.de>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125115>

Am 04.08.2009 00:13 schrieb Johannes Schindelin:
> On Mon, 3 Aug 2009, Dirk S=FCsserott wrote:
>=20
> I suspect the appropriate mailing list would have been the msysGit li=
st,=20
> then.

Sorry, next time I'll have a look there, but I'm more familiar with thi=
s=20
list. :-)

> How does your SCons call relate to Git?  Do you call it from the Git =
Bash? =20
> Do you call it from cmd.exe directly?  Is Git/bash in your PATH?

My SCons call doesn't actually relate to Git. I just use the Git-bash a=
s=20
my favorite shell under Windows. It's by far better than the regular=20
cmd.exe. Despite I'm using Windows, I'm a "shell person" and prefer not=
=20
to use only my index finger to direct the computer :-). Git-bash gives=20
that opportunity.

I used to call SCons from Git-bash and it worked. After Git's upgrade=20
(or some other unknown change) I did the same and it didn't work from=20
Git-bash, but it still worked from cmd.exe. Git-bash ist not in my PATH=
=20
when I run cmd.exe.

Don't bother, I just posed the question and hoped someone says "yeah, I=
=20
faced the same problem and solved it like this: ...". I'll use a=20
workaround and post a solution if I find one.

     Dirk
