From: "Ibrahim M. Ghazal" <imgx64@gmail.com>
Subject: Typo in git-reset man page.
Date: Fri, 19 Jul 2013 19:22:18 +0300
Message-ID: <CADfnUUKVDmuqt9s05ehrHVBVhtRFahna-r8=2_OpQW7ruUq+ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 18:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0DSS-00039x-Vv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760573Ab3GSQXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:23:00 -0400
Received: from mail-vb0-f49.google.com ([209.85.212.49]:34827 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759105Ab3GSQW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:22:59 -0400
Received: by mail-vb0-f49.google.com with SMTP id 12so3271853vbf.22
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=cR7n/MbshdWMglvRlGMDZ2SdnJkFlAfAFwy3GZNgJow=;
        b=AB/8Xh8RmE05VEEk6YbGOA9EgiKMAK7XhWtf/kA+ahsRmxMnvBqkApHFqhrQ5rIBj3
         9924k7Cn2m1MCR2vn6Bue5CX/dI8jCnu1KJctBQSVswoOKMKGnkuqDQNlOL+nEZ4CHJN
         ZwxFiaYclDtNB4JB7IcZC2M1+nfCp1/4YHdiskHe+ZH1TPsJ4WZsiZtc/9VFyiE4siuc
         RrE26Ge0szgEWzkR5ABXHfYZUBOq1TVjtLuUD4VfGJ2AZTQ9L+XCjqpQjvitpF5SGImR
         hAf1hHVeTeSlX49d0omEo6nhEmUyIGic4TBV2xbE4KhIt7bnGugMhffeK/rRwjU8lqv+
         Gehw==
X-Received: by 10.58.41.105 with SMTP id e9mr6057888vel.14.1374250979155; Fri,
 19 Jul 2013 09:22:59 -0700 (PDT)
Received: by 10.58.7.103 with HTTP; Fri, 19 Jul 2013 09:22:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230824>

On this line: https://git.kernel.org/cgit/git/git.git/tree/Documentation/git-reset.txt#n12

"tree-sh" should be "tree-ish".
