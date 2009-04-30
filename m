From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git config: error when editing a repo config and not
 being in one
Date: Thu, 30 Apr 2009 10:37:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904301036380.6621@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de> <1241045387-30181-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzRlr-0000m9-HI
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037AbZD3IhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 04:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759507AbZD3IhQ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:37:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:50310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760621AbZD3IhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 04:37:14 -0400
Received: (qmail invoked by alias); 30 Apr 2009 08:37:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp060) with SMTP; 30 Apr 2009 10:37:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MF6kLd26Mi4CCSSOEBxKOCKMITqn58oVeuz/9dH
	QRjZBZDE1CNc7U
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1241045387-30181-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118002>

Hi,

On Thu, 30 Apr 2009, Felipe Contreras wrote:

> Let's throw an error on this specific case. If the user specifies the
> config file, he must know what he is doing.
> 
> Teemu Likonen pointed this out.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I would have Acked it, but Junio already applied it ;-)

Ciao,
Dscho
