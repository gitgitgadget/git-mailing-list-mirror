From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] reduce progress updates in background
Date: Tue, 14 Apr 2015 10:47:33 +0200
Organization: gmx
Message-ID: <4c39d8b53964eadeb80f4898c525c42c@www.dscho.org>
References: <20150413134850.GC23475@mewburn.net>
 <20150414031227.GB591600@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git-owner@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 10:47:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhwVW-0004Cl-85
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 10:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbbDNIrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 04:47:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:53887 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbbDNIri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 04:47:38 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LxPNC-1ZSVoK44T4-0170rk; Tue, 14 Apr 2015 10:47:35
 +0200
In-Reply-To: <20150414031227.GB591600@vauxhall.crustytoothpaste.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:YFdrqxx8hsZOrzK3nIcXaCsHWUByT+ZGjC1dqE7SoM4jJPyakei
 OmPmyQzwKnv7YzooNP33yJ7b2atIZO5xhB9rKajP3Sw7liDYEeJkMaMYeUTHT4WqcyIY1KL
 auoj+HtdR0s3DUT8n59MatNpLWkVdhX1FpGZCfH+vcmeRRc+hyKFbkaKYXBV4LvROC0lCuO
 YiBp00HnGOmwpeSmUx0UA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267121>

Hi Brian,

On 2015-04-14 05:12, brian m. carlson wrote:
> On Mon, Apr 13, 2015 at 11:48:50PM +1000, Luke Mewburn wrote:
>
> I appreciated the opportunity to learn about tcgetpgrp(3).  The Windows
> folks will probably need to stub that function out, but they're no worse
> off than they were before.

Thanks for thinking of us!

Ciao,
Dscho
