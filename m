From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: text-based tree visualizer
Date: Tue, 18 Mar 2008 03:08:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803180300300.18817@fbirervta.pbzchgretzou.qr>
References: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr> 
 <46dff0320803170640g52411015g7bbe315df2b0bb56@mail.gmail.com> 
 <Pine.LNX.4.64.0803171716470.18817@fbirervta.pbzchgretzou.qr>
 <46dff0320803171726o4d7c23b4jbaae3cb0b3e09723@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 03:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbRGb-00057r-2b
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 03:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYCRCIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2008 22:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbYCRCIt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 22:08:49 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:33838 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbYCRCIt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 22:08:49 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id BDE511802F3A8; Tue, 18 Mar 2008 03:08:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id B65FC1C1B2557;
	Tue, 18 Mar 2008 03:08:47 +0100 (CET)
In-Reply-To: <46dff0320803171726o4d7c23b4jbaae3cb0b3e09723@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77481>


On Mar 18 2008 08:26, Ping Yin wrote:
>>  >Here is my view
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F Merge branch 'jk/portable'
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=97
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 Merge branch 'py=
/submodule'
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=
=E2=95=97
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 Merge =
branch 'db/diff-to-fp'
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=
=E2=95=AC=E2=95=90=E2=95=97
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 =E2=95=
=91 Merge branch 'cc/help'
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=
=E2=95=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=97
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 =E2=95=
=91 =E2=95=91 shortlog: do not require to
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F =E2=95=91 =E2=95=91 =E2=95=
=91 =E2=95=91 Merge branch 'maint'
>>  >=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=
=E2=95=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=97
>>  >
>>  >It seems messed up.
>>
>>  =E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82=
 =E2=94=82         =E2=94=82 =E2=94=82 Merge branch 'jk/portable'
>>
>> =E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=
=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=
=95       =E2=94=82 =E2=94=82
>>  =E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82=
 =E2=94=82 =E2=94=82       =E2=94=82 =E2=94=82 Merge branch 'py/submodu=
le'
>>  =E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=
=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=
=95=AA=E2=95=90=E2=95=95     =E2=94=82 =E2=94=82
>>  =E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82=
 =E2=94=82 =E2=94=82 =E2=94=82     =E2=94=82 =E2=94=82 Merge branch 'db=
/diff-to-fp'
>>  =E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=
=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=
=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=95   =E2=94=82 =E2=94=82
>>  =E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82=
 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82   =E2=94=82 =E2=94=82 Merge br=
anch 'cc/help'
>>  =E2=94=82 =E2=95=9E=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=
=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=
=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=AA=E2=95=90=E2=95=95 =E2=94=82 =
=E2=94=82
>>  =E2=94=82 =E2=94=9C =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82=
 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =
shortlog: do not require to run from inside a git re
>>
>>  Or was it something else you meant to describe with being messed up=
?
>>
>Thanks. That's it. I thought the normal looking would be
>
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F Merge branch 'jk/portable'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F  =E2=95=91 Merge branch 'py/su=
bmodule'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F  =E2=95=91  =E2=95=91 Merge br=
anch 'db/diff-to-fp'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=AC=E2=95=90=E2=95=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F  =E2=95=91  =E2=95=91  =E2=95=91=
 Merge branch 'cc/help'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=97
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F  =E2=95=91  =E2=95=91  =E2=95=91=
   =E2=95=91 shortlog: do not require to
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F  =E2=95=91  =E2=95=91  =E2=95=91=
   =E2=95=91 Merge branch 'maint'
>=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=
=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=97

git-forest relies on having a font with fixed-size cells.
xterm works (uses bitmap fonts, so no problem) works,
as does sakura (uses ttf, but fixed cells).
