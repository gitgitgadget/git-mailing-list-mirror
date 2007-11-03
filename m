From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Refactor working tree setup
Date: Sat, 3 Nov 2007 12:06:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031205390.4362@racer.site>
References: <1194088993-25692-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHmX-0003kT-1A
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbXKCMHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbXKCMHB
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:07:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:39264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752975AbXKCMHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:07:01 -0400
Received: (qmail invoked by alias); 03 Nov 2007 12:06:59 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 03 Nov 2007 13:06:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192a/hA3tV2F6ugFen0SEayDmBvCq58I71NpxZ8ES
	wyiIQrEvcSYhH3
X-X-Sender: gene099@racer.site
In-Reply-To: <1194088993-25692-1-git-send-email-mh@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63245>

Hi,

On Sat, 3 Nov 2007, Mike Hommey wrote:

> Create a setup_work_tree() that can be used from any command requiring a 
> working tree conditionally.

All three patches look fine to me.

Ciao,
Dscho
