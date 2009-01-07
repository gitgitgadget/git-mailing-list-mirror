From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Wed, 7 Jan 2009 13:45:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901071344360.7496@intel-tinevez-2-302>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>  <alpine.DEB.1.00.0901062319070.30769@pacific.mpi-cbg.de>  <c09652430901061436w36c013ep938e9cfba43140c9@mail.gmail.com>  <alpine.DEB.1.00.0901071101480.7496@intel-tinevez-2-302>
 <c09652430901070215p436db79boae4c56bfa1afbc1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1945460451-1231332311=:7496"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=D8yvind_Harboe?= <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 13:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKXo0-0007DM-T5
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 13:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278AbZAGMpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 07:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756213AbZAGMpP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 07:45:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:38251 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756042AbZAGMpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 07:45:13 -0500
Received: (qmail invoked by alias); 07 Jan 2009 12:45:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 07 Jan 2009 13:45:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194A/MQ4uJ489YFwuqnbQw4iyAO8sfbFIo4DpWzJp
	nPMhmDzAJy5Hmt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <c09652430901070215p436db79boae4c56bfa1afbc1a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104793>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1945460451-1231332311=:7496
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 7 Jan 2009, Øyvind Harboe wrote:

> How would git behave if it ran out of memory?

Something like

	fatal: Out of memory, malloc failed

Ciao,
Dscho

--8323329-1945460451-1231332311=:7496--
