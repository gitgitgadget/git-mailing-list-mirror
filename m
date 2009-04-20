From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Windows: Work around intermittent failures in
 mingw_rename
Date: Mon, 20 Apr 2009 12:01:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201201290.6955@intel-tinevez-2-302>
References: <49EC2BE1.9080200@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:03:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvqLf-0000RH-KS
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbZDTKB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbZDTKB5
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:01:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:58145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754118AbZDTKB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:01:56 -0400
Received: (qmail invoked by alias); 20 Apr 2009 10:01:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp005) with SMTP; 20 Apr 2009 12:01:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KEMJ3mVTKoM8Gd4YWqQ2tG/TmzxhACl3Hyj44nh
	wDeRGXLi5S0zql
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49EC2BE1.9080200@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116958>

Hi,

On Mon, 20 Apr 2009, Johannes Sixt wrote:

>  this is slightly different from the version that is currently 4msysgit: 
>  I removed the warning that was printed when a retry was attempted.

Makes sense.

Ciao,
Dscho
