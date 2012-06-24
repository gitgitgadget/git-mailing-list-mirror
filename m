From: lalebarde <l.alebarde@free.fr>
Subject: Re: Is it possible for a Client to have hosted repositories with
 different attributes ?
Date: Sun, 24 Jun 2012 00:32:15 -0700 (PDT)
Message-ID: <1340523135362-7562043.post@n2.nabble.com>
References: <1340287586020-7561927.post@n2.nabble.com> <4FE4A64E.50501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 09:32:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SihJW-0006Vq-UZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 09:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab2FXHcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 03:32:16 -0400
Received: from sam.nabble.com ([216.139.236.26]:40614 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2FXHcQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2012 03:32:16 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <l.alebarde@free.fr>)
	id 1SihIt-000574-C2
	for git@vger.kernel.org; Sun, 24 Jun 2012 00:32:15 -0700
In-Reply-To: <4FE4A64E.50501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200518>

Thanks for your reply neal.

Yes, I mean both 1) my "pc a 'client' of a server that is the host of a=
 git
repo", 2) I as a client of a git hoster.
Yes, I refer to .gitattributes
I am new to Git, so I have not yet decided for github or other.

But to clarify my need, I want a first repository on my PC, a second on=
e on
a second PC on my local network (kind of backup), and a third one hoste=
d
somewhere in the web to be able to work when I am out. At present time =
and
at least for one year, I am alone on my project, and it is not opensour=
ce.
So I want to protect my sources. I don't want them accessible by anyone=
=2E And
in case of hazard on the host (alien attack, bug, acking, malice
aforethought, industrial espionage, etc), I want to stay protected. Yes=
, I
am parano=C3=AFde .

So I want to add some filters, at least for keywords substitution and a=
 pice
of more things on what is hosted.

--
View this message in context: http://git.661346.n2.nabble.com/Is-it-pos=
sible-for-a-Client-to-have-hosted-repositories-with-different-attribute=
s-tp7561927p7562043.html
Sent from the git mailing list archive at Nabble.com.
