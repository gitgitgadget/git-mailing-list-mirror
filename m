From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: git-upload-pack stream
Date: Tue, 22 May 2012 18:35:47 +0200
Message-ID: <4FBBC063.3050108@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 22 18:36:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWs40-0004BT-5K
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 18:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab2EVQfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 12:35:53 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:56635 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab2EVQfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 12:35:53 -0400
Received: from [172.20.41.197] (p54A0C1F9.dip.t-dialin.net [84.160.193.249])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MTeXQ-1SfdTD0vlQ-00QhmK; Tue, 22 May 2012 18:35:51 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
X-Provags-ID: V02:K0:h1oS2Kt/Yhl3H5URE0BrUe9WaxKE4pCnT30Q4OL+pZw
 AwugyTPpHhSV01W31uBL67gJmKeEZ1Nn11hVlFkgx3mm/My1HD
 V5vKrnmiMaO/aUNORJe3N/ph6QaH+bmOvJfXqDD4z29VDWnoJz
 z1pikXg/CeOFyhke0YZ443MIZpMfR79bn0MqoskEBXmoZPgNG6
 RuAIHjaIdinNtngwskYvo/Of7fgmuv2IiiuiMJC6c8jWAzXEC4
 C9oOPYsnZOEjlLasMVvO9L4J1dwGPJq9RPfE4lwVnAewGdmMD8
 79t7pHy5++60v8e21s2P5HCot/1UNTyitu9N75dDXJHaEsX7lp
 fkTJ57QPVV3NxT2y3nxQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198203>

Dear List,

when pushing through http git-http-backend gets a stream of object when=
=20
sending the git-upload-packl command. This stream starts with two objec=
t=20
ids and a branch name. Is there a specification about how this streem=20
exactly looks like?

Thanks in advance,
=C1kos Tajti
