From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 13:14:45 +0200
Message-ID: <200706241314.46238.robin.rosenberg.lists@dewire.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com> <20070624065008.GA6979@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 24 13:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Q2g-0002UH-Pp
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 13:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbXFXLN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Jun 2007 07:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbXFXLN5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 07:13:57 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13004 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754194AbXFXLN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 07:13:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E0BC08026C8;
	Sun, 24 Jun 2007 13:07:07 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08137-03; Sun, 24 Jun 2007 13:07:07 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 75A008026C3;
	Sun, 24 Jun 2007 13:07:07 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070624065008.GA6979@efreet.light.src>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50792>

s=C3=B6ndag 24 juni 2007 skrev Jan Hudec:
> IMHO it should be the default even for email format. Most projects th=
at use
> non-ascii filenames probably have all members using same locale. And =
for
> such group, it will just work. Also usually the file names, content a=
nd
> commit messages will usually be in the same (though project-specific)
> encoding, so if charset in content-type is set to that, people with=20
different
> locale able to represent the same characters will still see the names
> correctly. For other people, the MUA will probably print some escape =
anyway
> (it will not screw up the terminal -- it usually knows what it can sa=
fely
> pass to it).

I can't talk about "most" here, only local conditions, i.e. northern Eu=
rope=20
where both the legacy ISO encodings are very common with a steady incre=
ase in=20
UTF-8 usage, in the Linux community. People using OSS in windows almost=
=20
exclusively get the windows-1252 (for most practical purposes the same =
as=20
ISO-8859-1).

Even a *very* small set of random people you will wind up with people h=
aving=20
different locales.

-- robin
