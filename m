From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 17:35:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902201734450.6302@intel-tinevez-2-302>
References: <499EC48B.9070004@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYN1-0007VD-Rj
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZBTQf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbZBTQf3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:35:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:60266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752715AbZBTQf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 11:35:28 -0500
Received: (qmail invoked by alias); 20 Feb 2009 16:35:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 20 Feb 2009 17:35:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WaQpvhdhWsfEhfLURWB1Wh3guuxUVi1KwVRI4Zp
	qFA4WiZo9yKlJv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <499EC48B.9070004@trolltech.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110860>

Hi,

On Fri, 20 Feb 2009, Marius Storm-Olsen wrote:

> +		local c
> +		+		if test "$(git config --bool core.bare)" ==
> "true"; then

Indeed, it seems that this got mangled, unfortunately.

Ciao,
Dscho
