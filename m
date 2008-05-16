From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Fri, 16 May 2008 13:02:47 +0200
Message-ID: <200805161302.47865.hs4233@mail.mn-solutions.de>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com> <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com> <alpine.DEB.1.00.0805161125320.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-15?q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 13:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwxmO-0008LC-Sy
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 13:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbYEPLG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 07:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbYEPLG1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 07:06:27 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:17470 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYEPLG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 07:06:26 -0400
Received: from lin01.mn-solutions.de (pD95FBFAE.dip0.t-ipconnect.de [217.95.191.174])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 17FAD5E4018;
	Fri, 16 May 2008 13:06:24 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id CD0931E004D; Fri, 16 May 2008 13:03:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 725D91E0004;
	Fri, 16 May 2008 13:03:29 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.DEB.1.00.0805161125320.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82274>

> No comment on the concern that it might break people's
> scripts?  None?

Scripts should look for exit values :-)
