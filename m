From: "Scott Chacon" <schacon@gmail.com>
Subject: Git Community Book
Date: Fri, 5 Sep 2008 12:08:44 -0700
Message-ID: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 21:10:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbggy-0005Xb-QD
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 21:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYIETIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 15:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbYIETIs
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 15:08:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:59571 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbYIETIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 15:08:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so51262ywe.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=wdTod41F51XxCEyOC7X5DP92jkFN7aUOuQYYWJy7GSk=;
        b=mfx2s0JCPaTI+4vyepG0AIy8y6fCvc/ZTgsV4wQ5utf9yCkwi0OLDOIfjZKcqz+dxT
         jMbt03iKhX4SKZWlIPYBisSMlcB/7WtbSGaKkt6laQQrmrib+lLz8PSy7r8vho4hQk0a
         WACFZ0F7PkDI4U8PPghzG/R1TQbn/FXWVPR2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=msYaVZ0qVncoEnNMqM7xPvoiKGat1iRt3NNsBB93uXJQKOxDcYQsqAjyJpelpHZhKg
         fTN+f1QD1FBWtHud9ztcpz+aBZ8mZQl0CDVtfx8ByBCSxES5AtJOH44LiJHy/VSMC6yJ
         2UxAYIrju2sgi/KooTa6YkxAeo7GjTLguOExI=
Received: by 10.115.50.5 with SMTP id c5mr10477386wak.60.1220641724382;
        Fri, 05 Sep 2008 12:08:44 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Fri, 5 Sep 2008 12:08:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95032>

Hey all,

I just wanted to let those of you who are interested know that I've
been making a lot of progress on the Git Community Book
(http://book.git-scm.com)  I was wondering if anyone was interested in
helping me with a few parts.  For one, there are some sections that I
personally have very little experience with, and was looking for some
notes/blog posts/personal experiences on, namely Advanced History
Modification (filter-branch, advanced rebasing, etc), Corruption
Recovery, Branch Tracking, Subversion Integration, Git with
Perl/Python/PHP, and Using Git with Editors (especially
NetBeans/Eclipse).

Also, the last section of the book is on some of the plumbing - mostly
stuff I've found difficult to pick up with the existing documentation
while re-implementing stuff in Ruby.  I would really appreciate it if
someone could proofread some of these chapters for errors:

http://book.git-scm.com/7_the_packfile.html
http://book.git-scm.com/7_raw_git.html
http://book.git-scm.com/7_transfer_protocols.html

Some of the next things I'm interested in producing is a cookbook
style guide and some searching tools for all the online documentation,
just to keep everyone up to date on where I'm going with the project.
Also, there is now a simple PDF downloadable version of the book
available and being kept up to date with the html version.

Thanks,
Scott
