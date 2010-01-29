From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] MSVC: Windows-native implementation of
 pthread_cond_broadcast
Date: Fri, 29 Jan 2010 21:13:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001292111350.3749@intel-tinevez-2-302>
References: <4B62CEAB.5050608@viscovery.net> <1264793213-8805-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1742405862-1264795991=:3749"
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: =?ISO-8859-15?Q?Zolt=E1n_F=FCzesi?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaxDT-00065q-2G
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab0A2UNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668Ab0A2UNO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:13:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:42271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754639Ab0A2UNN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:13:13 -0500
Received: (qmail invoked by alias); 29 Jan 2010 20:13:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 29 Jan 2010 21:13:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ou193Yj6oP+cAChv2jWkIWHLI20C/KjQx1y2uY6
	x3SlXoSJ5homfs
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1264793213-8805-1-git-send-email-zfuzesi@eaglet.hu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138345>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1742405862-1264795991=:3749
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 29 Jan 2010, Zoltán Füzesi wrote:

> Johannes, how about this?

Do you really mean me?

> I haven't tested it.

Then why the hell do you address me????

Seriously again, please test first before you post this. Once you have 
real proof that it works as you intend it, I will be _happy_ to have a 
look and most likely merge it into 4msysgit.git.  Before you tested it, I 
will be just annoyed.

Thanks for your work,
Dscho
--8323329-1742405862-1264795991=:3749--
