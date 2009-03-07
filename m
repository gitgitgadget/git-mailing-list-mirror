From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] http: use strbuf API in quote_ref_url
Date: Sat, 7 Mar 2009 18:32:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903071832270.10279@pacific.mpi-cbg.de>
References: <49B2A519.8050802@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 18:33:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg0O7-0008Na-0L
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbZCGRbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 12:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755303AbZCGRbK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:31:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:49205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755184AbZCGRbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 12:31:09 -0500
Received: (qmail invoked by alias); 07 Mar 2009 17:31:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 07 Mar 2009 18:31:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SWupBgToSmknS859QsBKJpcuNxLhA9tXeRbq+ay
	P23Dlq7QiAOqiT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49B2A519.8050802@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112555>

Hi,

On Sun, 8 Mar 2009, Tay Ray Chuan wrote:

> In addition, ''quote_ref_url'' inserts a slash between the base URL and
> remote ref path only if needed. Previously, this insertion wasn't
> contingent on the lack of a separating slash.
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Thanks, and ACK ;-)

Ciao,
Dscho
