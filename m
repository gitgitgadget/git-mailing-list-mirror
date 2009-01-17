From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] do not drop commits before the merge base
Date: Sun, 18 Jan 2009 00:41:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901180041180.3586@pacific.mpi-cbg.de>
References: <496F6AC3.7050704@drmicha.warpmail.net> <cover.1232233454.git.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 00:42:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOKoR-0005dR-0b
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 00:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762568AbZAQXlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760743AbZAQXlX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 18:41:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:40968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755573AbZAQXlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 18:41:23 -0500
Received: (qmail invoked by alias); 17 Jan 2009 23:41:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 18 Jan 2009 00:41:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Qihlp/3TQpn0UMI7FX7WoE42H+P0/8DVoIazpfh
	GBqKs3whjHNNdT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1232233454.git.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106112>

Hi,

On Sat, 17 Jan 2009, Stephen Haberman wrote:

> [... no patch, despite the subject...]

You probably wanted to use -n --cover-letter...

Ciao,
Dscho
