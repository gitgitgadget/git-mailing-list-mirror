From: pacco@tropezien.de
Subject: Re: How to use git-svnimport without trunk, tags and branches?
Date: Mon, 12 Mar 2007 16:10:32 +0100
Message-ID: <1173712232.45f56d6851a5f@secure.konsole-h.de>
References: <45F3EA37.2080502@tropezien.de> <20070311143638.GA7822@diana.vm.bytemark.co.uk> <45F434E9.7040003@tropezien.de> <20070311202620.GB15336@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?b?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQmAZ-00007i-3u
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 16:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbXCLPKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 12 Mar 2007 11:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbXCLPKf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 11:10:35 -0400
Received: from konsoleh1.your-server.de ([213.133.104.191]:3457 "EHLO
	konsoleh1.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030326AbXCLPKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 11:10:34 -0400
Received: from [127.0.0.1] (helo=localhost)
	by konsoleh1.your-server.de with esmtp (Exim 4.51)
	id 1HQmAS-0004SH-Io; Mon, 12 Mar 2007 16:10:32 +0100
Received: from proxy11.netz.sbs.de (proxy11.netz.sbs.de [192.35.17.11]) 
	by secure.konsole-h.de (IMP) with HTTP 
	for <pacco@tropezien.de@213.133.104.18>; Mon, 12 Mar 2007 16:10:32 +0100
In-Reply-To: <20070311202620.GB15336@diana.vm.bytemark.co.uk>
User-Agent: Internet Messaging Program (IMP) 3.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42034>

Zitat von Karl Hasselstr=F6m <kha@treskal.com>:

> You could try this:
>=20
>   trunk: dummy
>   tags: dummy
>   branches: svnrepos
>=20
No, it does not do that. Instead I got a huge amount of errors as with =
giving no
details at all (passing only the non-standard svn-repository).

But, I fixed the way around now, by scrutinizing through the history an=
d looking
for essential parts. I checkedout the specific versions seperately and =
rebuild
the history by cg-add'ing the file-versions one after the other. The ha=
rd way,
but there were not many really important files.

So, thank you a lot for passing me your help.

Ciao, Georg
