From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: [GSoC] Git popularity on GSoC
Date: Mon, 21 Jul 2008 22:07:03 +0200
Message-ID: <bd6139dc0807211307y720bbc07kfb1f2a6db3f25ed0@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 22:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL1g3-0001T2-Bg
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 22:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbYGUUHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 16:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbYGUUHF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 16:07:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:44731 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbYGUUHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 16:07:04 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1771526wfd.4
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=QcV99GlPUjaBRP4HcfxTGT/oF/IrY2wjuhsHidX3d9E=;
        b=EYlMwzmX18dzUtB67B5CjSR76Ia4p11vuOPN1EuinU87Y/KY0GDKHG8RoCUl9LTOrT
         TO/lbl6zaOjCcLjZjBKkSi0hZbARiigv9a1oO6cWsnKZiOrpe7EcIZUy6p98j6sxirbR
         kTUIRZdu0kssp4pv3CFvIU+g4Td0JoJWimtTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=dttnD12OWUMIE0SYd9MeQctHXq5gRMOpkX2EXlnpD5dRaRqp+GPP2Da9lbh1aLEYiA
         v8WV+adBC/6FJEZCxqg6GqWH930hDYRjY6PALg7KLj78YxCS3Br05oKFbWxTmzggWeAI
         7ioMZst8XHw3l1Gsbr+oFTQIxpCOQwnpBxtyo=
Received: by 10.142.52.9 with SMTP id z9mr1496950wfz.70.1216670823622;
        Mon, 21 Jul 2008 13:07:03 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Mon, 21 Jul 2008 13:07:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89399>

Heya,

There was a poll on the GSoC students mailing list: "What is your
favorite revision control system?". From the 100 responses so far, my
vote topled the balance in favor of Git ;). As a statistics junkie I
think it's fun to see that the only real competition among GSoC
students is Subversion, which has about as much market share as Git.
(Surely the 1 vote for TFS/SourceSafe must have been a misclick.) At
least nobody can claim we're the underdog RCS anymore!

Git		40% (40)
Subversion		39% (39)
Mercurial		7% (7)
CVS		6% (6)
Bazaar 		5% (5)
Perforce		1% (1)
Monotone		1% (1)
Microsoft TFS/SourceSafe		1% (1)
Other		0% (0)
BitKeeper		0% (0)

-- 
Cheers,

Sverre Rabbelier
