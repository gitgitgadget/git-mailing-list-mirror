From: Marco Costalba <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-2.3
Date: Sat, 9 May 2009 16:26:00 +0100
Message-ID: <e5bfff550905090826k5e235af1r36b3600bd1896efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 09 17:26:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2oRJ-0005Xz-Qo
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 17:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbZEIP0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbZEIP0D
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 11:26:03 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:63659 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZEIP0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 11:26:01 -0400
Received: by ewy24 with SMTP id 24so2457136ewy.37
        for <multiple recipients>; Sat, 09 May 2009 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=3dczlZc7cYU08+3I4H6qYF9oV4a94VvYvjQdeNxES+s=;
        b=HkSVSP6G86XSnle3LXXRm6O9vhbaJkvUiGxj0YCeHAmGsfUYobtNjUzvIzw7KY2Ve0
         tTG92UJ7gVWyO70G6vXUk/j5NpBP94F5QLEpyBbcO4UA2tO1TwDHOzJY2JtvYouiB0BI
         bokfPqbzbDY414tYYKgdbZizyWvTVNqsbs0Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rLYYPo3qyqwUWshtr6K8Oxq/oPqv2aMBJX0J1+PoBcsTFiTlcQrw0jFZQvAY4gYHmw
         BT99oQLNqXt4GVhCltYJC9ly5A6+xg/fZBKRbVM6A6ksDgxE9st3nqmiaa/yBjD0Y3ep
         e/GptPI1Pwbu5N3zpXW9rwy1lbQ+yctQ6suek=
Received: by 10.216.2.201 with SMTP id 51mr2294844wef.17.1241882760793; Sat, 
	09 May 2009 08:26:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118660>

Hi all,

   a new version of Qt4 based qgit-2.3 has been released both as
source tarball and as win installer.

You can download tarball and/or win installer from

http://sourceforge.net/projects/qgit



Or directly from git repository

git://git.kernel.org/pub/scm/qgit/qgit4.git


QGit is a git history viewer with a good bunch of related features.
See handbook (press F1 key), for a detailed list of features and how
to use them.
This is mainly a mainteinance release with some nice novelity as a new
graph look. You can browse through shortlog with contributors credits
directly from

http://git.kernel.org/?p=qgit/qgit4.git;a=summary



Thanks to all the people that helped in developing and pushing out this release.

Have fun
Marco
