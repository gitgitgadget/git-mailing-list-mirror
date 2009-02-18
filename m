From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] RUNTIME_PREFIX enhancements
Date: Thu, 19 Feb 2009 00:19:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902190019300.10279@pacific.mpi-cbg.de>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de> <499C63C2.3050405@kdbg.org> <alpine.DEB.1.00.0902182208070.10279@pacific.mpi-cbg.de> <499C9123.2070104@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 00:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZviO-0007Je-G1
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 00:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbZBRXTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 18:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZBRXTA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 18:19:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:52462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751685AbZBRXS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 18:18:59 -0500
Received: (qmail invoked by alias); 18 Feb 2009 23:18:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 19 Feb 2009 00:18:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DICY9dGtDHBKNggtVZeQd+gZ+pYeM9vuQrOuVWq
	At+baHV6K0H95i
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499C9123.2070104@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110593>

Hi,

On Wed, 18 Feb 2009, Johannes Sixt wrote:

> It's sad that your patch requires the source to live in a directory 
> named 'git'. But I don't know how to do it better. :-(

Let's move it to /bin/

Ducks,
Dscho
