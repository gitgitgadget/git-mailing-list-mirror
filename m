From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Tue, 10 Mar 2009 01:45:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903100143550.6358@intel-tinevez-2-302>
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 01:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgq7x-0005AA-MI
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 01:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZCJAp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbZCJAp6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 20:45:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:59039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753048AbZCJAp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 20:45:57 -0400
Received: (qmail invoked by alias); 10 Mar 2009 00:45:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp031) with SMTP; 10 Mar 2009 01:45:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HiGJ1PqOHsGGH2mbQRO1LJzuyV17Ck797Ri4T4P
	btvH/apTmLrlBL
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112772>

Hi,

On Mon, 9 Mar 2009, Junio C Hamano wrote:

> It appears that none of the issues I raised in my response to your 
> earlier round was addressed in this patch, except for the line 
> rewrapping of the proposed commit log message.

AFAICT my concerns were not addressed either: misleading subject unless 
the patch is split into two, remote specific config variable instead of 
global one, security issues.

Ciao,
Dscho
