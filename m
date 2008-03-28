From: =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@o2.pl>
Subject: [galtgendo@o2.pl: Re: Git vs svn. Is ... possible ?]
Date: Fri, 28 Mar 2008 15:34:49 +0100
Message-ID: <20080328143449.GD32646@blackspire>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 15:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfFff-0007oy-2q
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 15:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbYC1Ode convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 10:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbYC1Odd
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 10:33:33 -0400
Received: from mx10.go2.pl ([193.17.41.74]:53489 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755977AbYC1Odc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 10:33:32 -0400
X-Greylist: delayed 4211 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 10:33:31 EDT
Received: from poczta.o2.pl (mx10.go2.pl [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id 82FD35803F
	for <git@vger.kernel.org>; Fri, 28 Mar 2008 15:33:28 +0100 (CET)
Received: from localhost (host-89-228-42-12.elk.mm.pl [89.228.42.12])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP
	for <git@vger.kernel.org>; Fri, 28 Mar 2008 15:33:27 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78415>

----- Forwarded message from Rafa=C5=82 Mu=C5=BCy=C5=82o <galtgendo@o2.=
pl> -----

Date: Fri, 28 Mar 2008 15:15:36 +0100
=46rom: Rafa=C5=82 Mu=C5=BCy=C5=82o <galtgendo@o2.pl>
To: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: Git vs svn. Is ... possible ?
Message-ID: <20080328141536.GC32646@blackspire>
References: <20080328132438.GA32646@blackspire>
	<47ECF459.2040500@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47ECF459.2040500@users.sourceforge.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Status: RO

On Fri, Mar 28, 2008 at 02:36:25PM +0100, Adam Piatyszek wrote:
> Hi Rafa=C5=82,
>
> * Rafa? Mu?y?o [28 III 2008 14:24]:
>> Well, the actual question is:
>> In svn I can do a remote diff (diff between two remote revisions) wi=
thout
>> having to do a checkout, is this possible for git ?
>
> The question makes no sense to me. Git by design is a distributed SCM=
 tool,=20
> so there is no such thing like "remote revisions". You can have track=
ing=20
> branches (clones) of some remote repositories, but all the commits on=
 such=20
> branches are also stored locally. So you have full access to them, ev=
en=20
> without a permanent connection to such remote repositories.
>
It's a really simple question.
=46or svn I can do:
svn diff http:\\<svn path>@<rev. number 1>  http:\\<svn path>@<rev.
number 2>
Can I do the same for git, to avoid `git clone` ?

>
> PS. The encoding you used for your message is not playing well with t=
he=20
> Polish accented characters in your name ;)
I think it's your mail program, which is not plaing well with received
mail. My message was a standard, plain-text, UTF-8 encoded email sent b=
y
mutt.

----- End forwarded message -----

This was meant to be sent to the list, not to a single user.
