From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] t0027: Add repoMIX and =?UTF-8?Q?LF=5Fnul?=
Date: Wed, 15 Apr 2015 19:36:28 +0200
Organization: gmx
Message-ID: <c87875cc4da70fc671b40ba637421c94@www.dscho.org>
References: <552E9950.9050008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git-owner@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:36:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiREs-0001Gi-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbbDORge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2015 13:36:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:63236 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306AbbDORgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:36:33 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MO7Ca-1Yll9N23jo-005bCE; Wed, 15 Apr 2015 19:36:29
 +0200
In-Reply-To: <552E9950.9050008@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:3qKmqBDq1mRQ84Hap/Y2GNZNI1tsKQEKAm/v8gcWAB+gKsiuvQy
 QVuizykhcD9HYU2toMXFRYYBvwbVhZuIXQiDZOwmuBaH6YVP9Sh1noJabYa79QkEqbdjGpV
 oZjbd+1zgJSSN+v+GIckz6ppilY1MIWvbUNpPSP32iBb7f6MflzA60fxETVRVi2L6ZKUsd5
 PDQ6tLFOrH/NgwsTWCcqA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267223>

Hi Torsten,

On 2015-04-15 19:01, Torsten B=C3=B6gershausen wrote:

>  t/t0027-auto-crlf.sh | 155 ++++++++++++++++++++++++++++-------------=
----------

I fear that we duplicated work here, due to me working on Git for Windo=
ws 2.x and you sending mails to the non-Windows mailing list.

=46or what it is worth, my patches can be viewed here:

https://github.com/git-for-windows/git/commits/master/t/t0027-auto-crlf=
=2Esh

And in particular this one is important:

https://github.com/git-for-windows/git/commit/c07cae2576cd3ed193bb76695=
9f226a8fac5aa17

It would maybe be a good idea to work together?

Ciao,
Johannes
