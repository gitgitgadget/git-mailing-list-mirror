From: Carl Smith <carl.input@gmail.com>
Subject: Can I zip a git repo without losing anything?
Date: Mon, 26 Nov 2012 04:55:10 +0000
Message-ID: <CAP-uhDcQg0BuEdHDTa6qVqLCeB-LE1GZtEqHgY_j1--XodsDKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 05:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcqja-0002IX-U1
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 05:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab2KZEzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 23:55:42 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63738 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2KZEzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 23:55:11 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so5733844iea.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 20:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vLbx1aCGT6e4L8Zl99MRDNns7UpeR69mWZ/uohjvmhw=;
        b=nLveX+7rlr/FixsbyVWwcfhhaKQ3dp/2/Wn/bURSgteZ9TceJ8xZRwMGDysNXTEsOb
         q+fRON4K1LsoW2cMQE5cvrDNOIQQ4cs1M9K9mdo4T4W18x+o/V/Jr/KpU8BiTh6XzT9L
         1g5kTdmlIN0PB/px4YmDVakSNz1ia1IT5cvOtkwUcQg8KLYwZ1O01DgurxRRAbydA5UI
         JcJ0vygCABnrGTuygOMD53wul18P/xCKF7rWmWE8xjNa/w6FoetJc7JFZhA9SBBJn8Z4
         xGwfzv9E52lA++Z+nTxId0sksmMiljfb3H9/DfPDhTV1xtj+5EGle357gDm9mcKIvR0f
         Do9g==
Received: by 10.50.219.129 with SMTP id po1mr12385665igc.35.1353905710724;
 Sun, 25 Nov 2012 20:55:10 -0800 (PST)
Received: by 10.64.102.167 with HTTP; Sun, 25 Nov 2012 20:55:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210411>

Hi all

This is my first post to this list, so thank you for all your work.

After suggesting using zip files to move our projects around, I was
told that you can not zip a git repo without loosing all the history.
This didn't make sense to me, but two people told me the same thing,
so I wasn't sure. I think they may have been confusing the zipped file
you can download from GitHub with a zipped git repo.

If someone could put me straight on this, I'd really appreciate it.

Thanks

Carl
