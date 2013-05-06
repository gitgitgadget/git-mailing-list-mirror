From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 07:20:51 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1305060720060.8213@s15462909.onlinehome-server.info>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
 <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 14:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZKQL-00021B-KF
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 14:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab3EFMVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 08:21:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:54352 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695Ab3EFMUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 08:20:55 -0400
Received: from mailout-de.gmx.net ([10.1.76.29]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LiZpS-1U16eg1A5s-00cezp for
 <git@vger.kernel.org>; Mon, 06 May 2013 14:20:54 +0200
Received: (qmail invoked by alias); 06 May 2013 12:20:54 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp029) with SMTP; 06 May 2013 14:20:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SfOtOvUoSGCtguJ3v8bd8VImA/LU3i92Jqt+orq
	UNsvlpbzFPycBJ
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223444>

Hi Thomas,

On Mon, 6 May 2013, Thomas Rast wrote:

> The proposed patch wants to stop writing marks (in --export-marks) for
> anything but commits.

Then it should not go in.

Ciao,
Dscho
