From: viresh kumar <viresh.linux@gmail.com>
Subject: [Query] Update email-id in kernel source
Date: Wed, 13 Jun 2012 10:24:19 +0100
Message-ID: <CAOh2x=k==ZjqQk4bvvviz4Uy7Xg2yn0A+9vbYJ63VJa4qMCodA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spear-devel <spear-devel@list.st.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 13 11:24:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SejoO-00007K-UR
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 11:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab2FMJYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 05:24:20 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58428 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2FMJYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 05:24:20 -0400
Received: by obbtb18 with SMTP id tb18so595680obb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=3T50fueEj/HAMAgOuTumwrHwlaTCf9GmUj1OHDHDkCc=;
        b=ZH7/fhnByB6ibMC0ZCZfZuU50cFb+ufW5Z8ksBZIBQ8CQoTsFhRDuvvogiFJL8FHfP
         IYvuTgRogyK/ZnnTeZnEFeFnwE8wTXvuMwk+fDFY6VkEOeoqsq63OAsHL32Ql4TE5POm
         Rnd4vtVqpgfw5YTAaoh2ugrf6pm6+cq2tOGHN0kDKmsbjHM4eimElF4MZGF9PkTagwpk
         qA2KmZ1O1GtLX4XUJn4+W2jJZwdHjEaAK8L2UomeBF/3qqXTV+lOG9iDTNzby7a9SKgv
         t6SYOjqpYjClH1Oc1HNI3AjNjCstveZYGYMljeO1sPnWqkLCwqyysBTQ+EuFrabOpLTY
         GtCw==
Received: by 10.182.76.169 with SMTP id l9mr23784941obw.44.1339579459850; Wed,
 13 Jun 2012 02:24:19 -0700 (PDT)
Received: by 10.182.22.199 with HTTP; Wed, 13 Jun 2012 02:24:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199882>

Hi guys,

I have recently changed my company and am required to update my email address in
kernel source.

I can only see one way of doing that:
- Do a git grep, update all files, commit and post the patch.

Is there any better way of doing this that git provides, by which even
'git log' would show
the latest id available? I heard from a friend but don't know if it exists.

--
Viresh
