From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Minor issue: bad Spanish translation
Date: Wed, 10 Jun 2015 16:57:15 +0200
Organization: gmx
Message-ID: <813cfa8e53055e7c00ce98a5fe575b7d@www.dscho.org>
References: <1433947918.16619.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gabriel <gabrielperren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:57:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hRV-00067w-3s
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 16:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbbFJO5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 10:57:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:51748 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbbFJO5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 10:57:19 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LraSn-1ZAn8j0PEb-013KwU; Wed, 10 Jun 2015 16:57:16
 +0200
In-Reply-To: <1433947918.16619.0@smtp.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:6Yx9H8SlTseRYE6jGFRrnjKswwJTDBB8IQYzOooRh4DeuS9LD3l
 INaIh2YWHdEggMmJvi+pmarntQjhSN6W7HrpwAegYFvTZ5OvpminYfFe1pGI1R4rPfTm3kM
 iiaC5JOR2w7C+6mewoD66FzvL5jp7q886wgA/NYbKrlFJ1dQEs0n/sI5MF3V7Wcb1hkLWIu
 qx6BQcoS2qdQH7j5S/Ucg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271294>

Hi Gabriel,

On 2015-06-10 16:51, Gabriel wrote:
> Where it says:
>=20
> Su rama est=C3=A1 delante de <<origin/master<< para 6 commits.
>=20
> it should say:
>=20
> Su rama est=C3=A1 delante de <<origin/master<< por 6 commits.
>=20
> Notice "para" --> "por".

Good catch.

You could earn eternal fame by cloning Git itself (e.g. via `git clone =
https://github.com/git/git), finding the respective files with `git gre=
p`, patching them, making a commit and following the guide lines in Doc=
umentation/SubmittingPatches to contribute the fix via this mailing lis=
t[*1*]. That way, you would enter the illustrious group of core Git dev=
elopers.

Ciao,
Johannes

=46ootnote *1*: If you are more comfortable with GitHub's Pull Requests=
 than with sending patches via email, you could use https://submitgit.h=
erokuapp.com/ to turn a Pull Request into an appropriately formatted ma=
il to the mailing list.
