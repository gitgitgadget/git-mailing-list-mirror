From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] gitweb: gravatar support
Date: Fri, 19 Jun 2009 20:26:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906192025000.4265@intel-tinevez-2-302>
References: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:26:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHinH-0001K0-FS
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 20:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbZFSS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbZFSS0S
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 14:26:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:42554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751632AbZFSS0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 14:26:18 -0400
Received: (qmail invoked by alias); 19 Jun 2009 18:26:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 19 Jun 2009 20:26:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/K6k9G5ijKMvU9FJiuPR0FCUNruvVWtzIWHjR+yN
	R4rASVObUNRFtv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121904>

Hi,

On Fri, 19 Jun 2009, Giuseppe Bilotta wrote:

> Introduce gravatar support by adding the appropriate img tag next to
> author and committer in commit, shortlog and log view.
> 
> The feature is disabled by default, and depends on Digest::MD5, which
> is available in most Perl installations.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Something important is missing in this message, which was the reason why I 
had to go through the hassle of reading the source code to find out!

	This feature is optional and can be enabled by ...

Hth,
Dscho
