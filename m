From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH/RFC] Make "git remote rm <remote>" remove file refs/remotes/<remote>/HEAD
Date: Sat, 8 Mar 2008 00:18:36 +0200
Message-ID: <200803080018.36349.tlikonen@iki.fi>
References: <200803051338.44938.tlikonen@iki.fi> <1204923732-29141-1-git-send-email-tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 23:19:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXkuf-0000yl-JK
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 23:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbYCGWSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756554AbYCGWSj
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 17:18:39 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:40937 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756127AbYCGWSi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 17:18:38 -0500
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857001BA907 for git@vger.kernel.org; Fri, 7 Mar 2008 23:18:37 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <1204923732-29141-1-git-send-email-tlikonen@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76529>

Teemu Likonen kirjoitti:

> If more error checking or something is needed,

Such as finding the .git directory even if $PWD is somewhere else in the 
tree.

> I guess 
> somebody else has to do it; my skills aren't quite enough. :)

I'm out.
