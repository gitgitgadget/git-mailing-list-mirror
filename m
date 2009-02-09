From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
 an asterisk
Date: Tue, 10 Feb 2009 00:49:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 00:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWft0-0004CZ-5A
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 00:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZBIXsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 18:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbZBIXsb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 18:48:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:58961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1749667AbZBIXsb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 18:48:31 -0500
Received: (qmail invoked by alias); 09 Feb 2009 23:48:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 10 Feb 2009 00:48:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MwO8O0AQMnD8fuKGnoysdFtl6CyVYxtlNT5lgXe
	9J8Y1tDUDShlWx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109163>

Hi,

On Mon, 9 Feb 2009, Jay Soffian wrote:

> Teach git branch -{r,a} how to interpret remote HEADs and highlight the
> corresponding remote branch with an asterisk, instead of showing literal
> "<remote_name>/HEAD".

Let's hope that nobody's scripts rely on a single star in front of the 
local HEAD...

Ciao,
Dscho
