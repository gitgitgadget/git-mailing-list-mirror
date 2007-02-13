From: Xavier Maillard <zedek@gnu.org>
Subject: Re: Publishing on a simple HTTP server
Date: Tue, 13 Feb 2007 06:32:01 +0100
Message-ID: <19695.1171344721@localhost>
References: <14870.1171311025@localhost> <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 06:34:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGqJV-0005CE-LT
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 06:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbXBMFeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 00:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbXBMFep
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 00:34:45 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:49380 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161075AbXBMFep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 00:34:45 -0500
X-Greylist: delayed 33702 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Feb 2007 00:34:45 EST
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 35E8843060;
	Tue, 13 Feb 2007 06:34:44 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1D5W1bD019697;
	Tue, 13 Feb 2007 06:32:01 +0100
In-reply-to: <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
Comments: In-reply-to Johannes Schindelin <Johannes.Schindelin@gmx.de>
   message dated "Tue, 13 Feb 2007 00:11:22 +0100."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39496>

Hi,

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Mon, 12 Feb 2007, Xavier Maillard wrote:
> 
> > Cannot get remote repository information.
> > Perhaps git-update-server-info needs to be run there?
> 
> How did you upload?

I wrote a small LFTP mirror script.

I will check your tutorial but I am pretty sure I won't be able
to run all the commands (I, for example, can't do more than
connecting onto a FTP server at my FAI).

Xavier
