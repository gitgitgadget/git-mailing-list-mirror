From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Fri, 08 Jun 2012 21:55:25 +0200
Message-ID: <4FD258AD.6070601@web.de>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD24AE9.8020101@web.de> <20120608211540.Horde.SRiCRHwdC4BP0k9c5TdWBaA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 21:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5Hq-0001C1-6U
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 21:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640Ab2FHTzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 15:55:32 -0400
Received: from mout.web.de ([212.227.17.11]:64384 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933436Ab2FHTzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 15:55:31 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Ma2U7-1SORNX2vUt-00LelJ; Fri, 08 Jun 2012 21:55:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120608211540.Horde.SRiCRHwdC4BP0k9c5TdWBaA@webmail.minatec.grenoble-inp.fr>
X-Provags-ID: V02:K0:T/MDnLEvSVuIGz4gFGy3rRXcdIHZJSjGudMban3Be5E
 30Xs8kWvp4Dbl9215yA8hirmQ9+/7In32/a9D6cOzUN8KN+MBo
 u0r5X/X4yoccvE4Zw9dljHE4SUlIauEOiuvt7q9Knly3gMwfmd
 3BFtGdpp4oifor0XWDm0tbwNHQiHEgIXnf9vgCftbM+L3xfUMl
 WwhP9bdwhY2mXzQAw2ryQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199524>

On 08.06.12 21:15, konglu@minatec.inpg.fr wrote:
>=20
> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :

> Which part does not apply ? If you skip the part that's implementing =
the
> exec option, of course Git will not recognize it.


Hej,=20
2 questions:
a) Where should it apply ?
I tried to apply it on commit f623ca1cae600e97cb0b38131fdd33e4fb669cf8

b) Does the line from my log
"error: unknown option `exec'"=20
tell us anything?

/Torsten
