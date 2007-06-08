From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 8 Jun 2007 22:45:58 +0200
Message-ID: <20070608204557.GA18840@fiberbit.xs4all.nl>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.99.0706080931330.12885@xanadu.home> <20070608135054.GK2335@cip.informatik.uni-erlangen.de> <20070608153722.GL2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org> <20070608182412.GQ2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706081136480.4205@woody.linux-foundation.org> <alpine.LFD.0.98.0706081202580.4205@woody.linux-foundation.org> <20070608193319.GS2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 22:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwlLx-0003Zg-SD
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 22:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969877AbXFHUqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 16:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969860AbXFHUqg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 16:46:36 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:42661 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S969858AbXFHUqg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 16:46:36 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1HwlLK-0004wx-QC; Fri, 08 Jun 2007 22:46:00 +0200
Content-Disposition: inline
In-Reply-To: <20070608193319.GS2335@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49498>

On Friday June 8th 2007 at 21:33 Thomas Glanzmann wrote:

> Does someone know a command for debian that checks the checksums for every
> installed packages and the file that are included in that package?

Try debsums. Without arguments it checks all installed packages and
their files, but you can also check individual packages.
-- 
Marco Roeland
