From: "Thomas Perl" <th.perl@gmail.com>
Subject: Pingback/Trackback for Git?
Date: Tue, 3 Jul 2007 14:12:27 +0200
Message-ID: <372f54da0707030512k79e2dc74m98bf0a690abffc4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 14:13:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5hG4-0000fm-8o
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759955AbXGCMMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758925AbXGCMMe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:12:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:57631 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727AbXGCMMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:12:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1774132wxd
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 05:12:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SPmiNe9+naftU9byw/AXHT3J8LAwFaBPNtAnaaOYUj/mLyhlCymBT2IZSW3I2wtfO+lSbrmqGbgnHrAojIyk7VRNU7VWqM/ccZqmMrrRz7dhvF0EfwsCIt7KQTmjVjR/WPZ+qF0ectdg8c/51eMfnCUysX7KYs4bdwtr7GBv6gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iEIvrIUGzRBGfXes10uCr35pvIW4FQQacaqyHaWOuv+7oFzt+8RcDidyIEmBuNaf8yCEcf5u8IuAS9RFJXKdoNvos7kZswauoKFi6HlrU4q57bZnIxbZUebo98GHDiE/VSFJzHACs+tsPkLWDZcEpULjBng0q51cRFJCKd2iagk=
Received: by 10.90.97.11 with SMTP id u11mr5931831agb.1183464752360;
        Tue, 03 Jul 2007 05:12:32 -0700 (PDT)
Received: by 10.90.114.20 with HTTP; Tue, 3 Jul 2007 05:12:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51483>

Hello, Git users and developers!

I've been thinking about having some kind of pingback/trackback
support for Git repositories the same way pingback/trackback exist for
blogs. Apart from having a list of repository mirrors, it also allows
a developer to see a list of repositories from the same codebase.

I've outlined some ideas here, feel free to suggest implementations or
point out problems:

http://tperl.blogspot.com/2007/07/pingbacktrackback-for-git.html


Thanks,
Thomas
