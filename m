From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Eric Sink's blog - notes on git, dscms and a "whole product" approach
Date: Mon, 27 Apr 2009 10:55:55 +0200
Message-ID: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:23:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyMdZ-0002iY-Ch
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 10:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbZD0I4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 04:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZD0Iz7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 04:55:59 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:34033 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbZD0Iz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 04:55:58 -0400
Received: by fxm2 with SMTP id 2so2158658fxm.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=e4sI4pz6ZCA0o9507CXpbVm2wVaJpkAzqiQnDwuN3Es=;
        b=Oq4aiDznT3bmtpBM2o58ljPkdgu7qC5LNaaorSxddWbQbyJNcKmUTA3pgHNCzVaFfo
         lZvJiTT5sHthuRP/geUmAgEImfAbOUSIcE00Ikh/imVxPaF7lAxag5ain5lxbcbbbJS2
         q4Xxx4wDPCbSK6iLOAacwc8i2GJLJ3Q9Z34yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=hrjG7rvpCkUi0soBLppc99UNiVAakPvViuCwvpgfflGamdihnh7SJMC2bcvRkKpRuG
         ebHpa7ti2RXtZP1t4rtkcKdLPkaelYNjUmQz+CbiEPwIBv4Do2Lhb3yDoFP85RKDQZh1
         fGEx3pnRiZkksjaNg+yLPef9NSKmyqWqQBzjc=
Received: by 10.223.119.84 with SMTP id y20mr1603186faq.14.1240822555752; Mon, 
	27 Apr 2009 01:55:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117659>

Eric Sink hs been working on the (commercial, proprietary) centralised
SCM Vault for a while. He's written recently about his explorations
around the new crop of DSCMs, and I think it's quite interesting. A
quick search of the list archives makes me thing it wasn't discussed
before.

The guy is knowledgeable, and writes quite witty posts -- naturally,
there's plenty to disagree on, but I'd like to encourage readers not
to nitpick or focus on where Eric is wrong. It is interesting to read
where he thinks git and other DSCMs are missing the mark.

   Maybe he's right, maybe he's wrong, but damn he's interesting :-)

So here's the blog -  http://www.ericsink.com/

These are the best entry points
  http://www.ericsink.com/entries/quirky.html
  http://www.ericsink.com/entries/hg_denzel.html

To be frank, I think he's wrong in some details (as he's admittedly
only spent limited time with it) but right on the larger-picture
(large userbases want it integrated and foolproof, bugtracking needs
to go distributed alongside the code, git is as powerful^Wdangerous as
C).

cheers,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
