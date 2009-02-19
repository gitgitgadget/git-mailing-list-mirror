From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH JGIT] In the commit dialog, deal with Signed-off-by not on the last line
Date: Thu, 19 Feb 2009 18:28:25 +0100
Message-ID: <200902191828.25587.robin.rosenberg@dewire.com>
References: <499D2478.6080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 18:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaCin-0007iU-NZ
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 18:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbZBSR2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 12:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZBSR2a
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 12:28:30 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:41200 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506AbZBSR23 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 12:28:29 -0500
Received: from sleipner.localnet (213.67.102.59) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB03E5DEA6; Thu, 19 Feb 2009 18:28:26 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <499D2478.6080501@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110720>

Yann Simon <yann.simon.fr@gmail.com>writes:
> The previous implementation made the assumption that
> the Signed-off-by is always on the last line.
> 
> Correct this assumption and deal with Signed-off-by everywhere in
> the commit message.
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
> I hope this send will not be whitespace damaged.

Sorry, It suffers from severe whitespace burns. 

-- robin
