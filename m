From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/14] pull: check if in unresolved merge state
Date: Mon, 18 May 2015 21:06:33 +0200
Organization: gmx
Message-ID: <d9c322801fb2854061c63bf517e82d8f@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-8-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:06:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQNA-0004Bk-UA
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbbERTGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:06:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:52311 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbbERTGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:06:39 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M0y8F-1ZAr1Z2QAB-00v7Cf; Mon, 18 May 2015 21:06:34
 +0200
In-Reply-To: <1431961571-20370-8-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:2fKqOzxD/51lO1VY5TwjbkqC5NTq//i+Ez61PTGov+TSgqktidG
 /s3zVcvxLW4HjUpmzl03xHFY2QaOvs+NPSiDMuiNjPVQw6pSjurhkYPV2pPqB/U++93cbDw
 kNSLcFahqaXrU39dtUKDbfyo51kcMxRWguYbILF95jyYbVfVOVNgI4qtElq9cjWwXrRYyb1
 P/mzmMKOuci5frYx0Gp0Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269301>

Hi Paul,

On 2015-05-18 17:06, Paul Tan wrote:
> Since, commit d38a30d (Be more user-friendly when refusing to do

Let's remove this comma ;-) The rest of the patch looks fine to my eyes.

Ciao,
Dscho
