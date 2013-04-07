From: "Trenton D. Adams" <trenton.d.adams@gmail.com>
Subject: git instaweb - share all project files
Date: Sat, 6 Apr 2013 21:02:10 -0600
Message-ID: <CAMg8Y2pFXrbh8cz6m5z=LsksRijLVcV4fTk-TBx+9yaQTtAzpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 05:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOfs0-0005PA-Cr
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 05:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161370Ab3DGDCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 23:02:12 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:48081 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161311Ab3DGDCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 23:02:11 -0400
Received: by mail-ob0-f180.google.com with SMTP id un3so610794obb.11
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 20:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=GEkPyU2i2KHbp6l4sHI8Q/ACJlWMn75t65+KDy1r2D8=;
        b=R0MI2uMm0lH0GaFBt9xdGUV2VTY2HvkcAdXBOg8qWJu4aehG6MRG9mexzmC+iME4U6
         6ij9MTwIyipGCNmkRIqORKtgifhzbqgzAU8UM5H/6fWVtdDrUQ/AXrm6ASgmdifjyxI0
         PS6Y/AAdPEVoeaC37TS+Hh5Fz3V+wHTk24TZAMeHabdq48xm0U+3vl1hSC5qUOE/hIvk
         j/jiJWqO7XOF1I5qWuUfk98G89QdVTtPgtt9rTfMbJcvxWMzO/Ddl5+0KBTH4v+Wq8o4
         nkNNDDU1SaWNBaJmrSXn+9tJHZJpAeGjlVexNKH/dmdh1iLd3fFl4VsddTTy8ZUv9RVE
         sn0w==
X-Received: by 10.60.47.111 with SMTP id c15mr11772692oen.86.1365303730963;
 Sat, 06 Apr 2013 20:02:10 -0700 (PDT)
Received: by 10.182.228.8 with HTTP; Sat, 6 Apr 2013 20:02:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220274>

Hello,

On that first page that shows up, it shows the .git folder.  It would
be kind of nice if it shared out both the git repo and the actual
current project files.  I frequently have stuff I'd like to see in a
web browser, and even requires one (i.e. Navigating to
file:///home/blah/blah doesn't work; ajax requests for example)

Thanks.
