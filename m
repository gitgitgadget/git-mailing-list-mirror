From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: What are branches?
Date: Sun, 19 Apr 2009 17:17:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 17:16:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvYl9-0000Sr-Jf
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 17:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323AbZDSPPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 11:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758233AbZDSPPH
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 11:15:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:52158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757836AbZDSPPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 11:15:06 -0400
Received: (qmail invoked by alias); 19 Apr 2009 15:15:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 19 Apr 2009 17:15:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qEXMHN4Jq6VODgIn5uYISZ05IOw8mRULMENwkb6
	wFksd0SnURctUa
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116903>

Hi,

if you're like me, you used Git for _way_ too long to really understand 
how anybody can say that Git is hard to learn.  The concepts underlying 
Git have sunk so deep that I do not question them anymore.

But it is important to keep in mind that our concept of branches is not 
intuitive:

http://longair.net/blog/2009/04/16/git-fetch-and-merge/

In particular, we have some pretty confusing nomenclature when it comes to 
branches, and we might want to think how to improve the situation.

Food for thought on a lazy Sunday afternoon.

Ciao,
Dscho
