From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-reset: make the output as the fetch output
Date: Wed, 17 Jan 2007 14:43:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701171441250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87odox23u9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 17 14:43:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7B4H-0004Pu-01
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 14:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXAQNnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 08:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbXAQNnG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 08:43:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:36677 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932152AbXAQNnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 08:43:05 -0500
Received: (qmail invoked by alias); 17 Jan 2007 13:43:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 17 Jan 2007 14:43:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
In-Reply-To: <87odox23u9.fsf@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37001>

Hi,

IMHO your version is less helpful than the current behaviour: now it 
shows the oneline (which your version doesn't), and in most cases you 
reset from a dirty state (at least I _exclusively_ use reset in such 
situations), where "from..to" does not make any sense.

Ciao,
Dscho
