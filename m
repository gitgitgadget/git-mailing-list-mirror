From: Wincent Colaiuta <win@wincent.com>
Subject: "Select bg" in gitk preferencias
Date: Mon, 24 Mar 2008 10:15:33 +0100
Message-ID: <EC15D3E5-62A8-4DA6-BC53-2B5F83017132@wincent.com>
References: <1206316703-15481-1-git-send-email-sgala@apache.org> <9D1D2D11-8C2E-4B8E-BB75-59D155AFF6BF@wincent.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 10:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdin9-0002KU-CA
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 10:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbYCXJPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 05:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbYCXJPr
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 05:15:47 -0400
Received: from wincent.com ([72.3.236.74]:39601 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbYCXJPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 05:15:47 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2O9FZPi004772;
	Mon, 24 Mar 2008 04:15:36 -0500
In-Reply-To: <9D1D2D11-8C2E-4B8E-BB75-59D155AFF6BF@wincent.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78012>

In reviewing the patch just sent in by Santiago Gala (message-id: <1206=
316703-15481-1-git-send-email-sgala@apache.org=20
 >) I noticed the following little problem in the English version of =20
the gitk preferences dialog:

El 24/3/2008, a las 10:00, Wincent Colaiuta escribi=F3:

>> +#: gitk:8071
>> +msgid "Select bg"
>> +msgstr "Seleccione color de fondo"
>
> That's actually a misleading string in the English version of gitk. =20
> It actually means "Selection background", not "Select a background". =
=20
> So the translation should be something like "Color de fondo de =20
> selecci=F3n".


What do you think about changing "Select bg" to "Selection bg" (or =20
even "Selection background") in the English version to avoid this kind =
=20
of misunderstanding in the future?

Cheers,
Wincent
