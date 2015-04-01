From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: VCS popularity
Date: Wed, 01 Apr 2015 13:45:03 +0200
Message-ID: <vpqiodgnkcg.fsf@anie.imag.fr>
References: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com>
	<xmqq7ftwq06b.fsf@gitster.dls.corp.google.com>
	<CAA787rnbZGv_5rmVK1MLmCMLx9vpubW87hM4XK8U65i7FDZAiA@mail.gmail.com>
	<alpine.DEB.2.02.1503311615430.26359@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "=?iso-8859-1?Q?=D8yvind?= A. Holm" <sunny@sunbase.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Wed Apr 01 13:45:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdH5H-0003gu-CV
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 13:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbbDALpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 07:45:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60548 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbbDALpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 07:45:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t31Bj25F007852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Apr 2015 13:45:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t31Bj334016496;
	Wed, 1 Apr 2015 13:45:03 +0200
In-Reply-To: <alpine.DEB.2.02.1503311615430.26359@nftneq.ynat.uz> (David
	Lang's message of "Tue, 31 Mar 2015 16:18:26 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 01 Apr 2015 13:45:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t31Bj25F007852
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1428493507.46575@fftZfK0l4vsJ02rSOP/UXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266602>

David Lang <david@lang.hm> writes:

> How many of these 8230 git repositories are duplicates of each other
> on github (to pick a specific example).

Hard to tell exactly, but OpenHub does a reasonably good job at
identifying real projects and mirrors of a master. Distributed systems
probably artificially get a higher count, but it's not as bad as "each
fork of a project counts" at least.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
