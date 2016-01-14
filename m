From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Fix compile errors with MSys2
Date: Thu, 14 Jan 2016 07:53:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601140752250.2964@virtualbox>
References: <cover.1452691805.git.johannes.schindelin@gmx.de> <xmqq4mehnuo1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 07:54:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJbnh-00026w-5v
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 07:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbcANGxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 01:53:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:56503 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbcANGxv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 01:53:51 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsgvV-1aCqMt02K9-012L1l; Thu, 14 Jan 2016 07:53:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4mehnuo1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:R6Dm2kgGcb0xMrFkebmbLC+6euRmT+oDgwXh9CxqFoRn2QYXq7s
 p/pzVgKUqnuRNURWz5+J1SF6saWTZnGZDeznjOWi4kQpfhSdR2jSvBbFzao7oCyf1oZ22f7
 HjwgbAnhM4LS90MwmzA++EL8fbUq3CxK4pic7AzvE360O3T5bI7Bx8fxPhn6mecYK2oYczm
 Uyb5w57UaPhIs9tWOFy4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r7bMNgv+59g=:KXu1iDSR/sXL+WoqWv4Mgq
 wZv4vigOu72B0D8tASaQckaKT0HTAXmRTV+x68ru08nT09kr3fwTeovff/BFjnfyK3/lT+JKD
 0cEVapTWddC3VlQ9XJC8PZm8rXHJqzVUCBf0Ky02LtTiWNGny0BoWx6J0YK9mLQ9J/mhqvhWe
 z1YndTfMhxgrts0xmZtHvdioq+3PRVNV3dmfERRT5qLk0/p+rqtlYeNdp2DL+6b2FmieZSASj
 NuLmzEMwmO6PDjJCpXDTNjtS9UentEAi3GB/XeH/XUSDjioDyKZfwm6XOeYwSoFsHELaGc7X2
 kGA8tU5WMacd5Je59P5Xb7snY9sUIhskjqiLDbcsbwMdQkON8H/kIrHtW/nFedMiR8a2GN2A1
 Y2NWI3eFIfcOvmcCOU7eV3QV5d5Twhzagu8IFPC6U8BebOte2LYRj5kIYTX0O9RvkYgpG7dFx
 RKUSSiKFJKniPHjEc+9CX7l0YG51DwSxP+QZwVqo8Y4uaWkWLDJb762QsnxXm5ffPw4YDseeB
 eLKFT3QPnNMJK1iGXvzoradxjKb/RLluoJ4/M/6qbuUfoWBORPzcQ8xLdjmWMqtF2o8TYFxbN
 odYUc5cGpH2aBCs7hbLlT6ZhQ9g41kV9kpLh4MOe+5Z8l5japiekEuTVHqckwH8xGD8KLdVzM
 KuSqpspSOecA89sQpRTXLgJOHRmI9VwMXphX5AXueNUq2SX++mBt9YnNKeO91cn7ijZM0InNH
 xsTvUH0EZKvM6trjtaABLU/CV6CCsKKMuwgoGA1mmjL1bqJGN76tzkw13JweCBBFfrBTwM+q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284020>

Hi Junio,

On Wed, 13 Jan 2016, Junio C Hamano wrote:

> It would really be nice to see the endgame of what this series
> starts sometime not in too distant a future.

That is indeed the intention:

	https://github.com/git-for-windows/git/issues/285

Ciao,
Dscho
