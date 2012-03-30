From: jaseem abid <jaseemabid@gmail.com>
Subject: [GSOC][HELP] Incremental blame in gitweb.
Date: Sat, 31 Mar 2012 02:36:56 +0530
Message-ID: <CAH-tXsDHJ98LLcHVs5U-OYS1maKoM+sDn6hw5HeD6c6wZ8mBHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 00:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDkXL-00064s-Mz
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 00:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935269Ab2C3WnC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 18:43:02 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55694 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935221Ab2C3VHh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:07:37 -0400
Received: by wibhj6 with SMTP id hj6so956882wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=Tcc5LXJ03GXv6NLf0d60bCwmHlEgnbLiAFd5hYnYb1g=;
        b=MELUI17JzyM+uf2wsq/3fEjWJoO2/cLrbUY4W6df/VvUXTveX671gXn8VoE11VVPjs
         rJeoVe4KOHpqXnH/FMf4gR/VTa81Tp1gcDH1Io/t6EoMIcgxjdZiGzcRnTXGxnn8QiK+
         uLkBxChbsvTFP9VHRmKcOY1jk0GKjkF2fBoHdyTaluooIWDdWcyj8WIfD1L4xcCMGCLu
         E/taijsBcQinmIeOS9bkEzwNolixSahmcnH5F3PKY/CFa9ZbZgGv3PGVWxJ1FnlMNWcz
         6zKf7rbfQtgsXyx5+zJl0Hb04s4ePtvc+VwqqpP/1qCQznbUlqMkpemz3XpR1VB0tiuj
         73Uw==
Received: by 10.180.101.136 with SMTP id fg8mr597840wib.4.1333141656345; Fri,
 30 Mar 2012 14:07:36 -0700 (PDT)
Received: by 10.227.155.6 with HTTP; Fri, 30 Mar 2012 14:06:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194420>

Hello again,

I was learning from the gitweb source code and I am a bit stuck at a
particular point.
What does incremental blame do in gitweb? I tried to get some
information from the documentation.
I was expecting it to be used for pagination of huge git-blame output
or something similar. Doc says it can be used for similar purposes
I notice code written in JavaScript for AJAX calls etc, but i cant
find a place where it is being used. Can somebody give me a link to
one in k.org or somewhere for a demo? I tried to find some AJAX calls
in the web console but cant trace any. I'm a bit confused here.

Any help will be very much appreciated.


-- 
Jaseem Abid
+91 8891 72 43 72
S6 CSE student
National Institute of Technology , Calicut.
