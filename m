From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: diff: ignoring changes in certain subdirectories
Date: Wed, 25 Nov 2009 14:40:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911251439230.13979@intel-tinevez-2-302>
References: <9ab80d150911250527j60707333n736c09fcdbdba3a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-193669317-1259156415=:13979"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Zolt=E1n_F=FCzesi?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Wed Nov 25 14:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDI6x-0003gc-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 14:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934771AbZKYNkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 08:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934699AbZKYNkM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 08:40:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:44813 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934744AbZKYNkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 08:40:11 -0500
Received: (qmail invoked by alias); 25 Nov 2009 13:40:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 25 Nov 2009 14:40:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dFdlx6gGdLYj2Ie8EAknbNwxvEGqRDKoboFrqh7
	PRIdDcZoWobgvE
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <9ab80d150911250527j60707333n736c09fcdbdba3a7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133641>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-193669317-1259156415=:13979
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 25 Nov 2009, Zoltán Füzesi wrote:

> Hi All, I would like to check changes between branch 'A' and 'B', 
> ignoring subdirectory 'xyz'. Is there a simple way?

I implement half of this for --no-index some time ago:

http://article.gmane.org/gmane.comp.version-control.git/110846

Feel free to take it to completion,
Dscho

--8323329-193669317-1259156415=:13979--
