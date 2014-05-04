From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed
 filenames
Date: Sun, 04 May 2014 14:04:21 +0200
Message-ID: <53662CC5.3040105@web.de>
References: <20140428161630.GA9435@sigill.intra.peff.net> <xmqqvbtskqjv.fsf@gitster.dls.corp.google.com> <20140429180210.GB11832@sigill.intra.peff.net> <53610F76.3050209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 14:05:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgvAV-0004hz-27
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 14:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbaEDMFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 08:05:12 -0400
Received: from mout.web.de ([212.227.17.11]:49871 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390AbaEDMFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 08:05:11 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MKek3-1WfXqD1wPP-0021lV; Sun, 04 May 2014 14:04:22
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53610F76.3050209@web.de>
X-Provags-ID: V03:K0:ekif8rHuZiXcY8qTW8r3EgFkQE250x+GLMp30PKwCWONQAxyyCN
 q/+oAq+tow6tzDXHDGUrki43+gC1lHWQZs5QVE7gqmslZgxAEoAe9eoEBLlkPGRr6Cm7EL4
 njWLcTN0FYsopGVRxJp8Z/IR/n7fwAxqdv81Ii+u3cyo9ddvwxFEn4KxEEASxY53Y0y9KER
 /a8roARTpC7eUNB+W40Gg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248094>

On 2014-04-30 16.57, Torsten B=C3=B6gershausen wrote:
There is something wrong with the patch, (test suite hangs or TC fail),
so I need to com back later. Sorry for the noise.
