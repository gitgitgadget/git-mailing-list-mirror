From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] git-gui: Improve the application icon on Windows.
Date: Tue, 27 Nov 2007 21:47:22 +0100
Message-ID: <200711272147.22511.johannes.sixt@telecom.at>
References: <1196177124-13601-1-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0711271539310.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix7LU-0007pI-HA
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 21:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbXK0Ur0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 15:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756062AbXK0Ur0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 15:47:26 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:53842 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbXK0UrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 15:47:25 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 7AD2D13A987;
	Tue, 27 Nov 2007 21:47:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3D7D54AA1E;
	Tue, 27 Nov 2007 21:47:23 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711271539310.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66259>

On Tuesday 27 November 2007 16:40, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 27 Nov 2007, Johannes Sixt wrote:
> > Previusly, there was only a 16x16 image, which looked very distorted.
> > Here we add a 32x32 version, and also make the image sharper.
> >
> > Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> > ---
> > 	I'm by far not an artist, but improving the previous version
> > 	was not difficult at all. ;)
>
> Why did you not just use the svg contained in msysGit?

Because I cannot find one?

$ GIT_PAGER=cat git grep -i svg 4msysgit/devel
4msysgit/devel:attr.c:   * attributes, e.g. "*.svg      merge=special-...

-- Hannes
