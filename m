From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] blame: CRLF in the working tree and LF in the repo
Date: Thu, 30 Apr 2015 09:53:25 +0200
Organization: gmx
Message-ID: <83824ee9e8a2ea1e08b05aadbdd2d1b7@www.dscho.org>
References: <5541B2A4.8050108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kasal@ucw.cz
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 09:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnjHs-0004Cq-HK
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 09:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbbD3Hx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2015 03:53:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:62455 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbD3Hx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 03:53:27 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lmazv-1ZN3u23crj-00aEkW; Thu, 30 Apr 2015 09:53:25
 +0200
In-Reply-To: <5541B2A4.8050108@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:85zbPIfgoFx2yhroV45a/KIZbIH2FWiInOU6gs/IwjTcpN6Sfmg
 XflDH7RMjz/ucg9o/KTaJIB9tnUcHLrk5QBFDiLOW9iJiq0GSPzWGjTcTyf/GEJcoMmy28i
 Ay4NUP/Ppr/Q7VxX6bNhqp3OgU7agwQPhGfyAS0PhOROFYG2MD7qDEgFfJqcjWepgSSZxsA
 /BRPQ1W0aIsM1b5xI0rbg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268060>

Hi Torsten,

On 2015-04-30 06:42, Torsten B=C3=B6gershausen wrote:
> A typicall setup under Windows:

s/ll/l/

> What happened to the test cases ?
> They where improved, but it turned out that they failed
> from time to time, both Windows and Mac OS.

Have you had a chance to investigate the failure symptoms? This is worr=
isome.

Ciao,
Dscho
