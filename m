From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH v2] git-gui: Update Russian translation
Date: Wed, 14 Oct 2015 16:18:57 +0300
Message-ID: <1444828738-14200-1-git-send-email-dimitriy.ryazantcev@gmail.com>
References: <87r3kx91at.fsf@red.patthoyts.tk>
Cc: git@vger.kernel.org,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 15:20:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmLyL-0000P9-3c
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 15:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbbJNNT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 09:19:56 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34554 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbJNNTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 09:19:54 -0400
Received: by wicgb1 with SMTP id gb1so129952013wic.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJR53gL5XajXR9jO6MfD/Y0dyjyMKUj+MFkgbr8JeBY=;
        b=BjAbsP9zOD6lD9xYEq38GO0UZWF6dAQBPXcIBocMvYbzTiTrr92TRu5vm5lKAAhA6/
         mJ2RO7sNRm5f8FJY6Y2Epzf07VglNIpZfD9voq+S7DBZFXnCvL75r7QVI3cByNBTb8pB
         Wc/jhwdqRh8WqmuBs2ErTrYCKF1TR7pW0nXzgW0GbrM3unwBpUZYm4kTY3nug4OGNnNV
         IwL4qnaHZujO53Wk/J46GCZ3T79EkuoCrXZB6ptI/z9CoJUGffho6HHaI8vGceYnMXFl
         HElE61stV22nGJV1EV9Zin5/T723V7e1foWC9NMrgFbOchgJklKkPh929gAXbvdShzms
         Xkwg==
X-Received: by 10.180.93.232 with SMTP id cx8mr4361203wib.26.1444828780125;
        Wed, 14 Oct 2015 06:19:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:d0:8c94:0:dc2e:713e:8976:a916])
        by smtp.gmail.com with ESMTPSA id h7sm10041020wjz.7.2015.10.14.06.19.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2015 06:19:39 -0700 (PDT)
X-Mailer: git-send-email 2.6.1.windows.1
In-Reply-To: <87r3kx91at.fsf@red.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279570>

>This section seems wrong as it replaces the existing copyright notice
>with some auto-generated junk. As it is a translation I should think the
>copyright is with the translators but it should not be using default
>placeholders.
Sorry for that. It seems that a Transifex bug, I uploaded po with copyrights
to them. Sent a mail to Transifex support. For now I replaced it manually.

Dimitriy Ryazantcev (1):
  git-gui: Update Russian translation

 po/ru.po | 668 +++++++++++++++++++++++----------------------------------------
 1 file changed, 243 insertions(+), 425 deletions(-)

-- 
2.6.0
