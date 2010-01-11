From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] string-list: remove print_string_list, since it is not
 used anymore.
Date: Mon, 11 Jan 2010 22:52:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001112252040.4985@pacific.mpi-cbg.de>
References: <1263245389-1558-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:59:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUSIV-0004xM-RI
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 22:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab0AKV7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560Ab0AKV7e
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 16:59:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:56978 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750712Ab0AKV7e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 16:59:34 -0500
Received: (qmail invoked by alias); 11 Jan 2010 21:46:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 11 Jan 2010 22:46:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YCF0yBfNYvIaANzfKPzlaG/uwGQIwRDhVrLCo5m
	7l5wRc/XYkm+FH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1263245389-1558-1-git-send-email-tfransosi@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136669>

Hi.

On Mon, 11 Jan 2010, Thiago Farina wrote:

> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---

It was never used, except for debugging.  Does it hurt you really all that 
much?

Ciao,
Dscho
