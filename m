From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Documentation/technical/api-hashmap: Remove source
 highlighting
Date: Sat, 17 May 2014 20:50:35 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1405172035160.44324@all-night-tool.MIT.EDU>
References: <alpine.DEB.2.02.1405170707260.44324@all-night-tool.MIT.EDU> <20140517152219.GA31912@hudson.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 02:50:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlpJR-0004mZ-SM
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 02:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbaERAuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 May 2014 20:50:40 -0400
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:63934 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751620AbaERAuj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 20:50:39 -0400
X-AuditID: 12074425-f79746d000000ecc-78-537803dea9e2
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 15.D0.03788.ED308735; Sat, 17 May 2014 20:50:38 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id s4I0obfp001051;
	Sat, 17 May 2014 20:50:37 -0400
Received: from localhost (all-night-tool.mit.edu [18.9.64.12])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s4I0oZmk005227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 20:50:36 -0400
In-Reply-To: <20140517152219.GA31912@hudson.localdomain>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixG6nonuPuSLY4NAiPouuK91MFm8e5Tow
	eeycdZfd4/MmuQCmKC6blNSczLLUIn27BK6MK3P/MRYc5K5YceY5UwPjUc4uRk4OCQETiSOn
	tjNB2GISF+6tZ+ti5OIQEpjNJLF5/iFWCGcjo8S1D0uhMruZJH7efcYK0sIioC1x6O8+NhCb
	TUBNYu6GyewgtoiAhsS9a1uZQWxmAXGJTcvfgK0QFgiTuPvoKlgvp4CFRN+B+4wgNq+Ah8TX
	vbvB6oUESiS+zzoCNkdUQFdic/dSNogaQYmTM5+wQMxUlzjw6SIjhK0tcf9mG9sERsFZSMpm
	ISmbhaRsASPzKkbZlNwq3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjODwdVHdwTjhkNIh
	RgEORiUe3sZL5cFCrIllxZW5hxglOZiURHkbfgGF+JLyUyozEosz4otKc1KLDzFKcDArifD6
	3wXK8aYkVlalFuXDpKQ5WJTEed9aWwULCaQnlqRmp6YWpBbBZGU4OJQkeJ2AcSokWJSanlqR
	lplTgpBm4uAEGc4DNFwXpIa3uCAxtzgzHSJ/ilFRSpy3mwkoIQCSyCjNg+uFpZdXjOJArwjz
	GoC08wBTE1z3K6DBTECD3+wtBRlckoiQkmpgPB9afDFm/d+tk6ebeVYoiopuPLv1XHJ/kyzX
	Qk1p6Qamc3GnJivNy/nOH7pooaPlxjNxWzZWcjHGLV57f5PA0r4Xa8pmKG6U/NTC/EB9Y2G/
	vWf17yCnG7+3ua1YXSP459881niV++fv/9q8+4wF16yjF5z0HZcKz5mS/zG+wtRk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249495>

On Sat, 17 May 2014, Jeremiah Mahler wrote:
> I agree that a broken document is an unacceptable failure mode.
>=20
> But I do not understand why 'source-highlight' is not an install
> requirement for 'git-doc'.  If I install 'source-highlight' on
> my Debian machine the code looks great.
>=20
>   apt-get install source-highlight

Yes; when I noticed this failure, I asked Jonathan to add source-highli=
ght=20
as a build dependency in Debian (https://bugs.debian.org/745591).  But=20
then Ubuntu forked the packaging to revert this change=20
(https://bugs.launchpad.net/bugs/1316810), because source-highlight in =
the=20
community-supported universe repository is not allowed to be a build=20
dependency of git in the Canonical-supported main repository.  So now t=
he=20
Ubuntu package still has broken documentation _and_ it=E2=80=99s lost t=
he ability=20
to automatically synchronize updates from Debian.

If we=E2=80=99re going to make Git depend on source-highlight, then we =
would want=20
to make sure it=E2=80=99s documented in INSTALL and that its absence is=
 properly=20
diagnosed.  Maybe then we could make the argument to Canonical that=20
source-highlight should become officially supported in main=20
(https://wiki.ubuntu.com/UbuntuMainInclusionRequirements).

But I don=E2=80=99t that would be worth it just to make one page of the=
 API=20
documentation a little more colorful (and it sounds like you agree).

Anders
