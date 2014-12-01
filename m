From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Mon, 1 Dec 2014 08:44:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412010843570.13845@s15462909.onlinehome-server.info>
References: <cover.1417033080.git.johannes.schindelin@gmx.de> <cover.1417041787.git.johannes.schindelin@gmx.de> <ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de> <xmqq1tokrrad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 08:44:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvLfF-0001js-P2
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 08:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbaLAHox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 02:44:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:56083 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbaLAHox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 02:44:53 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MFctN-1XhL1Q1VW1-00EhDA;
 Mon, 01 Dec 2014 08:44:49 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq1tokrrad.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:4Qw4WZk2HQ+BlcWDAKqY8TB8kbMugVkz/Xka+xHKeKDf6eIBLi9
 Ee+Hbf8zji22RB0Fz3Hq37TWpTjyDCb8f0uyyvP2bQ+NgYANfx6MPNgzR6RNlqlMu6tCKit
 n9OH4DNROorD726mkvK0lHMx+7nY7x1t15meT/B18ah2H7OCpqm58db7Ba8340XWcuN59l9
 ldTzd+9njYFY5clpm3z2w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260474>

Hi Junio,

On Sun, 30 Nov 2014, Junio C Hamano wrote:

> Thanks, will queue.

Thanks!

> I think we would need a bit more tests to protect the feature from
> future changes, if you care about the cleanliness requirement of
> this feature which is a lot stricter than that of "git checkout".
> 
> Perhaps like this one on top.

Thanks again!
Dscho
