From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: gitk doesn't always shows boths tags in "gitk tag1..tag2"
Date: Tue, 29 Jan 2013 21:11:38 +0100
Message-ID: <51082CFA.4050501@gmx.de>
References: <510825B2.6070805@gmx.de> <20130129195718.GD18266@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 21:12:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0HXJ-0008OA-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 21:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab3A2ULn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 15:11:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:54485 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab3A2ULm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 15:11:42 -0500
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LZkBu-1UhGi01uFo-00lY3C for
 <git@vger.kernel.org>; Tue, 29 Jan 2013 21:11:40 +0100
Received: (qmail invoked by alias); 29 Jan 2013 20:11:40 -0000
Received: from e177120189.adsl.alicedsl.de (EHLO [85.177.120.189]) [85.177.120.189]
  by mail.gmx.net (mp020) with SMTP; 29 Jan 2013 21:11:40 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX1/h+YpRCwbh6d4wTuhf5m4Fw21TuKr7rKdEqTQYWh
	ucACrB8BgQsPRb
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130111 Thunderbird/17.0.2
In-Reply-To: <20130129195718.GD18266@google.com>
X-Enigmail-Version: 1.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214968>

On 01/29/2013 08:57 PM, Jonathan Nieder wrote:
> As you guessed, 7.0.45 seems to live in a different area of history. =
:)
Well, seems be point to the root cause ..

BTW
$> gitk  --simplify-by-decoration  client_release_7.0.44..client_releas=
e_7.0.45

only 3 rows in the main window where=20
$> gitk client_release_7.0.44..client_release_7.0.45

shows 468 rows.=20


Thx for the quick answer :-)

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
