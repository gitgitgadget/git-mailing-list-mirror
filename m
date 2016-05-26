From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.9.0-rc0
Date: Thu, 26 May 2016 15:24:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605261523160.4449@virtualbox>
References: <xmqq60u47403.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605261156070.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 15:25:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5vHT-00038f-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 15:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbcEZNYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 09:24:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:50552 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbcEZNYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 09:24:51 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LgNGi-1br2Gu1JpM-00neCD; Thu, 26 May 2016 15:24:44
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1605261156070.4449@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cE3dk8ADwLBtAzsyUYubzm8Koy1YNvIKGUu1Xj/zAul61ODc0rU
 HC3ua6COq6IVfyrQ8+qoXEM2SAmU71dEl9FixMGk4ChXFZdpwFh2y9t0sRQ76FHqdSLvzmj
 eAc0ehRZtZ2dn/fsWYqXk9R2ZVMwwZU4Pjx1G8+T8puL5Jra7V+vUfV7NmxZpLKpVjEDO3U
 jsiNxFMtaQl2bvh1xBJ+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WuoYwlO23lE=:mM5voLrlkIqmPT+oJTPh/B
 BD63pD8SWqTKD3tFvGxWa/b8nL9qzPZCeHCFkClIWJl0se2u73wVN5Z+D6YOyWbla/AzWNUKB
 w5bDEbPRQ94N8AY6F5xGsWEM9CCMUgJ5gxj1nc3UybhBFvwLQUgdV6nX2gpNs0WzWw7+vTIke
 r8iD21zI7l14i7X1Gba6msCGMEDu6SPgJqKkg0NYSPyH3xxsTWrCDWwFOsWzqf2OdkrK7kpnp
 KoDazL3kQYhEr39B1N6qvpj09vo0xbCFjB5FgeC/Gn51GX4mCasL0y3Pk/u3yfmQ1ntfq0rHY
 PXKXGJg0CAEUzbOGR3Qp5p9zrdyJ9mV6gM0D1sf+OFO2QcLC5DqvU6eXTTkS+RFJxThtTsvPQ
 HY3SWcBVGZxP9TCXVjgirCojQ9A+dZzwGgxoqaTtnPkgR6p0SX1hKQ6jm4lNidwSDqMg2MlnF
 KwFF4gl8aiQ19qydcCySW1/M9rp6vQMQ8reUJ3RV3GUzegcboe0og0bP54NGcwPvMP/L51lSG
 4h6ZONvx8sy2Z475v7o9Usk8kIr/d1IiGl+RJ6nDtsjla9L646VOxUE1Oihr/Klwk2nOxPPZ1
 4L/nvW3xx/T4Db+eTZErU+V/HcxgZFmKUBBFM4wJ3YxhfYz/s0siibhAIefPjr4+e8sYpozc4
 Yt9ESCpSl9rYAe6Z8O/TjQaJZBBReNZibj8p6Wi0QVORnERkvSAXWWiffD1ccbZZNiX0FnGgW
 GyV9nSM4Sa9310y31BpAE0PjoTpOnjFS8DtAxUjRBWIMhn/JeD6dqEBZ2wwh2gv9ml+pfMng 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295651>

Hi all,

On Thu, 26 May 2016, Johannes Schindelin wrote:

> On Mon, 23 May 2016, Junio C Hamano wrote:
> 
> > An early preview release Git v2.9.0-rc0 is now available for
> > testing at the usual places.
> 
> Thanks. I pushed out a tagged source-only Git for Windows v2.9.0-rc0 for
> interested parties:
> 
> 	https://github.com/git-for-windows/git/releases/tag/v2.9.0-rc0.windows.1

Very sorry: the tagging revealed a flaw in one of the patches and I had to
re-tag. My apologies to anybody who already fetched the previous tag.

Ciao,
Dscho
