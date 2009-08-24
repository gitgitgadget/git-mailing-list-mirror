From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: sr/gfi-options, was Re: What's cooking in git.git (Aug 2009, #04;
 Sun, 23)
Date: Mon, 24 Aug 2009 16:45:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908241641390.11375@intel-tinevez-2-302>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfanO-0006pc-Gy
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbZHXOpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZHXOpK
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:45:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:48679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752600AbZHXOpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:45:09 -0400
Received: (qmail invoked by alias); 24 Aug 2009 14:45:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 24 Aug 2009 16:45:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PJ1MPmHnPVzAeQJb0SwZBxCvkcfzMrCxI9JKCxt
	O+NFC+EQXdX7F9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126937>

Hi,

On Sun, 23 Aug 2009, Junio C Hamano wrote:

> * sr/gfi-options (2009-08-13) 3 commits
>  - fast-import: test the new option command
>  - fast-import: add option command
>  - fast-import: put option parsing code in seperate functions
> 
> What is this used by?

By a hg-fast-import Sverre was writing for me:

http://github.com/SRabbelier/hg-git/tree/fast-export

Sverre hinted at the possibility of ripping this out of hg-git and putting 
it into a hg:// helper.

Ciao,
Dscho
