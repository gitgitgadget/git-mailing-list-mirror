From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] Use run_command() to spawn external diff programs
 instead of fork/exec.
Date: Sun, 30 Sep 2007 22:10:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302210260.28395@racer.site>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-3-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-4-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-5-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic655-0002QT-5W
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbXI3VL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbXI3VLz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:11:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:45858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752325AbXI3VLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:11:54 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:11:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 30 Sep 2007 23:11:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Vb8kM191VP/4XBFTA44ZiTRpAQOU6GcyeVuZfUq
	3fIHoO7uE1cimC
X-X-Sender: gene099@racer.site
In-Reply-To: <1191183001-5368-5-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59565>

Hi,

On Sun, 30 Sep 2007, Johannes Sixt wrote:

>  diff.c |   38 +++-----------------------------------
>  1 files changed, 3 insertions(+), 35 deletions(-)

_Nice_!

Ciao,
Dscho
