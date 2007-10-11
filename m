From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: added support for update -p
Date: Thu, 11 Oct 2007 21:59:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710112158330.4174@racer.site>
References: <200710101316.03633.jan@swi-prolog.org>
 <1192120573-16765-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Jan Wielemaker <jan@swi-prolog.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:00:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig58V-0007vK-Fx
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601AbXJKU7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 16:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbXJKU7x
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:59:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:44164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755231AbXJKU7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 16:59:53 -0400
Received: (qmail invoked by alias); 11 Oct 2007 20:59:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 11 Oct 2007 22:59:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YhxUhKMVYy/E/zzjjP5ppIpSFMNDHrJrg6gejXF
	tYnbtRB3OY4+f3
X-X-Sender: gene099@racer.site
In-Reply-To: <1192120573-16765-1-git-send-email-frank@lichtenheld.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60636>

Hi,

On Thu, 11 Oct 2007, Frank Lichtenheld wrote:

> +	if ( exists ( $state->{opt}{p} ) )

I see you kept the coding style, which is not in agreement with the rest 
of git...  Intention or oversight?

Ciao,
Dscho
