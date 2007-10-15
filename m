From: Mark Watts <mwatts42@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 20:05:00 +0000 (UTC)
Message-ID: <44f2ad561ade78c9dd5c4607b8ca@news.gmane.org>
References: <Pine.LNX.4.64.0710151938300.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 00:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhXrC-00046e-78
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 23:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759762AbXJOVv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 17:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbXJOVvZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 17:51:25 -0400
Received: from main.gmane.org ([80.91.229.2]:50398 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbXJOVvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 17:51:24 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IhXfO-0001ht-9B
	for git@vger.kernel.org; Mon, 15 Oct 2007 21:40:02 +0000
Received: from cpe-24-24-82-42.stny.res.rr.com ([24.24.82.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 21:40:02 +0000
Received: from mwatts42 by cpe-24-24-82-42.stny.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 21:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-24-82-42.stny.res.rr.com
X-Newsreader: JetBrains Omea Pro 1098.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61048>

Hello Johannes,

> My bigger concerns are the performance and stability.  For example, I
> had a very annoying problem on one of the machines I am testing
> msysGit on.  The problem was _only_ fixable by deactivating component
> of Logitech's WebCam driver!  Now, if a user-installable 3rd party
> program can make my regular git crash, I am scared what more it can
> do.

Not just git.  This driver has known issues with a number of pieces of software. 
 The company I work with uses Delphi quite a bit and they also have Logitech 
WebCams for the devs and for some reason this driver makes debugging impossible 
with Delphi.  I have personally experienced this.  I have also heard of this 
Logitech software having problems with other software too.  I have not however 
tracked down exactly WHY this piece of software causes so much grief, only 
that it does.

-mark
