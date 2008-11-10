From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] 3-way merge with file move fails when diff.renames =
 copies
Date: Tue, 11 Nov 2008 00:41:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811110039280.30769@pacific.mpi-cbg.de>
References: <1226355970-2542-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgHK-0003pi-HM
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbYKJXd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbYKJXd2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:33:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:55683 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752951AbYKJXd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:33:28 -0500
Received: (qmail invoked by alias); 10 Nov 2008 23:33:26 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 11 Nov 2008 00:33:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2vkoq3a+2mpDuHyef8L3shqT9YFRqPR7bLwYtZ7
	u8bhCsWNkkWRZO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1226355970-2542-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100591>

Hi,

except for the commit subject I like it, especially the commit body. So:

s/(3-way.*) fails/Fix &/

Ciao,
Dscho
