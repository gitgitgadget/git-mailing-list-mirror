From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 00:35:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903100033400.6358@intel-tinevez-2-302>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 00:36:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgp1b-0008S7-Je
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZCIXfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbZCIXfS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:35:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:36132 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752002AbZCIXfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:35:16 -0400
Received: (qmail invoked by alias); 09 Mar 2009 23:35:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 10 Mar 2009 00:35:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GAWl1BLQGjRzdb6SgM3++ga9IjZdDZ9IRLvSi6+
	pUIeGPnAs9lGT4
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112762>

Hi,

On Mon, 9 Mar 2009, Finn Arne Gangstad wrote:

> git push default change:
> 
> git push will by default push "nothing" instead of "matching".

Hasn't this been shot down already?  I do not want that change.  I think 
it is harmful.

At least without a proper way to prepare existing users for the end of the 
world.

Ciao,
Dscho
