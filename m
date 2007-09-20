From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] add support for branch.<name>.integrationonly
Date: Thu, 20 Sep 2007 14:14:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201413440.28395@racer.site>
References: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
 <1190292789-16203-2-git-send-email-hjemli@gmail.com>
 <1190292789-16203-3-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 15:15:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYLsG-0001do-2m
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 15:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbXITNPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 09:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbXITNPN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 09:15:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:42770 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753101AbXITNPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 09:15:11 -0400
Received: (qmail invoked by alias); 20 Sep 2007 13:15:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 20 Sep 2007 15:15:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SVHZsVQxStPLiHMayETo3RltrQP1dz39fcOaQXE
	SAt7op11ihIeNG
X-X-Sender: gene099@racer.site
In-Reply-To: <1190292789-16203-3-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58777>

Hi,

On Thu, 20 Sep 2007, Lars Hjemli wrote:

> +branch.<name>.integrationonly::

Why not have something like branch.<name>.mergeOptions instead?

Ciao,
Dscho
