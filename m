From: Yuri Mikhailov <yuri.mikhaylov@gmail.com>
Subject: Load testing of git
Date: Sun, 24 Feb 2013 13:54:34 +0100
Message-ID: <CAGjB8pR+uByiJJikBXbaxUZO4rDgyfvJ31agxaQuWrMwSS1N7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 13:55:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9b6j-0005wP-6r
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 13:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622Ab3BXMyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 07:54:35 -0500
Received: from mail-ia0-f171.google.com ([209.85.210.171]:39410 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3BXMyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 07:54:35 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so1761467iaz.2
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 04:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=1bevD+JTIMyWi7wLVRbP6pron0WcEyNGmd8XGBUVDOs=;
        b=l+XYMRDWiLOOCWCPD899+W4EvzAIWHHIaRb0uSnif1e2enfupX9HRzcWFKWuDDIKUG
         i1U55E+7eo4F1FK0Wu/PD1b5xnad4NHXOCgDtj2pKLzLuD96zyCGTj2J6gjIZd0kP1ys
         cS/9+RPzZKgR5R4UBYyVAw5dTou7MVuiN0L/7Cy7K4yyOReoXOlt+1Tl25eGDyzGpOwq
         YZk0OOj4DKQ3CzksQPws9SL9OM016k111BXHBZpCVazQ8ZdSCxQSEp4fOU0Sw69sV/q8
         XOrn32gQEhZSgP/7Ldh20H+DpLxtyCoMnemPttx3TR0nGVhGudhI637UL5CPuYyVqbrk
         sS3A==
X-Received: by 10.42.159.194 with SMTP id m2mr3162078icx.13.1361710474765;
 Sun, 24 Feb 2013 04:54:34 -0800 (PST)
Received: by 10.64.37.4 with HTTP; Sun, 24 Feb 2013 04:54:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216987>

Dear Git community,

I am a Software Developer and I have been using git for a while.
Currently my company is looking for a version control system to use
and we find Git a good candidate for us. But what is important for us
to know is scalability of this VCS. Does anyone performed load testing
of Git? What is the practical maximum number of files and revisions
this system can handle?

Best regards,
Iurii Mykhailov
