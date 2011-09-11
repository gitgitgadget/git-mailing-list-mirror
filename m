From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Recorded talk on using git-svn
Date: Mon, 12 Sep 2011 00:14:01 +0200
Message-ID: <CAEcj5uWnJ8vGJH5fPV5VPEF3zaOS8T_fT7BQb3ruj5hd1=QMiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 00:14:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2sI7-0005MN-Ix
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 00:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1IKWOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 18:14:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63895 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1IKWOC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 18:14:02 -0400
Received: by gyg10 with SMTP id 10so2636024gyg.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FxIo3Bel78HsM0W8KmQZcF1jLGIiAOebIPq2vAx6IEM=;
        b=Bv2VPi3xk93T2zzXWDqDWTEZwY3Bg12OMd0Az7P8GKN7vmUo0yYC/Efd9fotT5fx0m
         3XakQI2HCYPTajBXOWouHu4jKic1JndXTPSvH+OKO8IfXW2Jz8AylQLqYTq3Fn0eCQM2
         v4UXBP7kWpTs/WtzGHLCimVV0g/CYqXvhdX70=
Received: by 10.231.66.85 with SMTP id m21mr6120547ibi.53.1315779241439; Sun,
 11 Sep 2011 15:14:01 -0700 (PDT)
Received: by 10.231.210.139 with HTTP; Sun, 11 Sep 2011 15:14:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181201>

Hi,

I just did a talk at JavaZone this week about using git-svn, and the
recording is now online:

http://vimeo.com/28762003

The demo features normal use of git-svn, plus setup of a git-svn
mirror, using Jenkins to automatically sync the git mirror, and then
putting the mirror on Github.
Maybe some here will find it useful.
