From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: add -e, was Re: What's cooking in git.git (Apr 2009, #04; Wed, 29)
Date: Thu, 30 Apr 2009 11:26:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904301125230.6621@intel-tinevez-2-302>
References: <7vy6tivh7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 11:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzSXX-00051N-Kj
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 11:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbZD3J0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 05:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbZD3J0j
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 05:26:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:50918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751393AbZD3J0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 05:26:39 -0400
Received: (qmail invoked by alias); 30 Apr 2009 09:26:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp038) with SMTP; 30 Apr 2009 11:26:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XL05o0ArXuz5MLEBVon7CIBc6MnX8AXjiSR2sUb
	6HMH57a/6N6dBE
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vy6tivh7a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118008>

Hi,

On Wed, 29 Apr 2009, Junio C Hamano wrote:

> * js/add-edit (Mon Apr 27 19:51:42 2009 +0200) 2 commits
>  + t3702: fix reliance on SHELL_PATH being '/bin/sh'
>  + git-add: introduce --edit (to edit the diff vs. the index)

I think I asked if there should be a short description on top of the diff 
you edit (just like the usage you see in rebase -i's edit script at the 
end)... Opinions?

Ciao,
Dscho
