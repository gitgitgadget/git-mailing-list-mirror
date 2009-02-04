From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git daemon on different port
Date: Wed, 4 Feb 2009 12:26:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902041226270.22763@intel-tinevez-2-302>
References: <loom.20090204T111635-586@post.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-288986485-1233746819=:22763"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Stefan_N=E4we?= <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 12:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUfvm-0002pm-OB
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 12:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZBDL1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 06:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbZBDL1E
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 06:27:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:57264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750903AbZBDL1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 06:27:02 -0500
Received: (qmail invoked by alias); 04 Feb 2009 11:27:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 04 Feb 2009 12:27:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hVzx0M2xh60DRPR23b0BHSY0Eec0cjyPAH3Pxn4
	DitX/y7LIBpcx9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <loom.20090204T111635-586@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108334>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-288986485-1233746819=:22763
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 4 Feb 2009, Stefan Näwe wrote:

> git daemon --port=12345....
> 
> would set the git daemon to listen on port number 12345, right?
> 
> Question: What would be the clone URL then ?

git://example.com:12345/repository.git

Ciao,
Dscho

--8323329-288986485-1233746819=:22763--
