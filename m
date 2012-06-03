From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Gentoo is moving to git
Date: Sun, 3 Jun 2012 19:49:54 +0700
Message-ID: <CACsJy8DbL6RqVmEyrSFNj1w-nZR1hPnoz5+AvYJSRoibiMd1Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 14:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbAGM-0004Bu-Uk
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 14:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab2FCMu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 08:50:26 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40922 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab2FCMu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 08:50:26 -0400
Received: by wgbds11 with SMTP id ds11so1718535wgb.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3+mCantUBvjx8ANnB7sH5jdOPrDz5FVPud0PN1st0K0=;
        b=ugwNg44dc7r/kPNMnKu3VL+7VW9RRIKXutSlIybBz8mriPQL0VwSXSjoI0zHyXzioO
         BmlUg3yEW/zU19sdQ/U/gcO6cUBB6y/q5QkaDh5UB4ZAOAAivofJyR5x2Kx6M3WXQRj0
         CIyJZ5PA2LqDwRpdA9CAFb+GmGfqvKNQkNkKxq6BU1TN9YNa863w1BNRP/in695Ekv7t
         IGGiclr+adH0sdtmk5nhSWU1Vpx+MzrIFTlZIvQwytJxm+FL3ODhPf7QBsHFe5cUqThX
         6ZPHQbndn+jUCWiQaLSTN1b/JIntr+xGXAYVYfjcO7XCUcxV4Q4M6qkT6bNnhBMdkVg4
         gqqw==
Received: by 10.216.194.196 with SMTP id m46mr8308137wen.197.1338727824493;
 Sun, 03 Jun 2012 05:50:24 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sun, 3 Jun 2012 05:49:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199085>

No big news. But as Gentoo may be the first user of commit signing
feature and the repository has a special shallow and wide tree
structure, it may be interesting to watch how it works out:

http://thread.gmane.org/gmane.linux.gentoo.devel/77537
http://thread.gmane.org/gmane.linux.gentoo.devel/77542
http://thread.gmane.org/gmane.linux.gentoo.devel/77193 (loong and
probably not technically interesting)
-- 
Duy
