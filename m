From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] receive-pack: support push-to-checkout hook
Date: Fri, 9 Jan 2015 09:44:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1501090943460.21312@s15462909.onlinehome-server.info>
References: <xmqqbnm8etxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:48:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9VBB-0005V0-Il
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 09:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbbAIIoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 03:44:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:52900 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755929AbbAIIoU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 03:44:20 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MbgWb-1YPn6l44gf-00J1pV;
 Fri, 09 Jan 2015 09:44:11 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqbnm8etxg.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:q2MlaG7LkcDwt4LI8rOgG3gtolwXmjAyyL03lWZyGyMD4Ktb4W7
 ajrpj8ZAwzLVkhEW7vp7jcKt5pDwL8k84oIBhTqn+GabsWrUTY4OHh+w+tileT0rDutTUrl
 Xl31rnHJoo9pZPQcAVFbv6WdMmKTtKX1gs8ewrBen14Tp/itwYx0j26E+MvhdXgvt8cETFU
 I3J+XAVd8JiAXCxpHUv1Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262235>

Hi Junio,

On Thu, 8 Jan 2015, Junio C Hamano wrote:

>  * This is an update to $gmane/260527; relative to what I have been
>    keeping in 'pu', the only difference is that it comes with
>    documentation updates.

Thanks, it is very nice!
Dscho
