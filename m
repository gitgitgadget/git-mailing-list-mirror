From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix mistakes in the documentation of git-add --interactive.
Date: Wed, 7 Nov 2007 22:25:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711072224200.4362@racer.site>
References: <200711072150.18751.barra_cuda@katamail.com>
 <1194472947-8601-1-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptL5-0006By-8m
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbXKGWZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbXKGWZT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:25:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:50865 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753578AbXKGWZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:25:17 -0500
Received: (qmail invoked by alias); 07 Nov 2007 22:25:14 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 07 Nov 2007 23:25:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1800P86MWs01ISfdP07r+ZDCMZSMm1gBuj0PblpD2
	0OH6e6zwmlAM8I
X-X-Sender: gene099@racer.site
In-Reply-To: <1194472947-8601-1-git-send-email-tsuna@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63875>

Hi,

On Wed, 7 Nov 2007, Benoit Sigoure wrote:

> -       a - add the change from that hunk and all the rest to index
> -       d - do not the change from that hunk nor any of the rest to index
> +       a - add the change from that hunk and all the remaining ones
> +       d - do not the add change from that hunk and skip the remaining ones

This still sounds funny.  How about

	d - skip this hunk, as well as the remaining ones

Hmm?

Ciao,
Dscho
