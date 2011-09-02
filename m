From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: Special characters in file name
Date: Fri, 2 Sep 2011 12:38:09 +0000 (UTC)
Message-ID: <loom.20110902T143646-347@post.gmane.org>
References: <4E60C6D0.7090609@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 14:38:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzT0y-0004KV-9h
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 14:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab1IBMi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Sep 2011 08:38:26 -0400
Received: from lo.gmane.org ([80.91.229.12]:59475 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab1IBMiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 08:38:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QzT0q-0004EK-E8
	for git@vger.kernel.org; Fri, 02 Sep 2011 14:38:24 +0200
Received: from 212.34.37.3 ([212.34.37.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Sep 2011 14:38:24 +0200
Received: from zapped by 212.34.37.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Sep 2011 14:38:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.34.37.3 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.215 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180608>

Tajti =C3=81kos <akos.tajti <at> intland.com> writes:

>=20
> Dear List,
>=20
> I have a file named "=C3=A1rv=C3=ADz.txt" in my repository. When modi=
fy that file=20
> and execute git diff, the first line looks like this:
> diff --git "a/\303\241rv\303\255z.txt" "b/\303\241rv\303\255z.txt"
>=20
> Is there an option that (if specified) will get git to print "=C3=A1r=
v=C3=ADz.txt"=20
> instead of this escaped string?
>=20
> Thanks in advance,
> =C3=81kos Tajti
>=20

please, refresh your memory )))
http://comments.gmane.org/gmane.comp.version-control.git/177849

see my comment
http://permalink.gmane.org/gmane.comp.version-control.git/177857
