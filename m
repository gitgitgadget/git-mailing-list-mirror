From: Allan Kelly <allankelly@gmail.com>
Subject: Show current SHA1
Date: Sat, 11 Jul 2009 10:39:44 +0100
Message-ID: <9586f3420907110239nbc35aealb473e1f1b3667410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 11:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPZB8-00061Q-Ru
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 11:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZGKJr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 05:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbZGKJr2
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 05:47:28 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:46978 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbZGKJr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 05:47:27 -0400
Received: by fxm18 with SMTP id 18so1334454fxm.37
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=9JpRpJsEfBfbNU9rf5J0NT3ZXYvyK0ZwlfeP9GhYn78=;
        b=cZXL6vHZwouhNrTm5DS0bzMeR5SJ66kdrcqr2gu4CynId8FQsK9GrVGCJwLnXn2Yb3
         8VMKm8D9c+nfthRI1Fe/9wXnBhpOBnxoSS8hJFTbr4VYi+ttT4VBTv/Ml+c7X7O3uyHA
         4ts1zkhZ+XVOIU3IP8aPZk30XnYHKckBr+HLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rYN/YewnrKtGwahLPphYj/3OB7oWYA/69GEu5zSGdt1Oro3bbShjib121X55MLzbZf
         MRKhol0v+Vqh9MHc9PjQ43mhgmpfC01jgEWTHq1ld9m/InEVesgGNzNEB0gXpHtfxEvJ
         FGaKcYpCXggghqmxdcrj3sQAxAtthmCP5Y1so=
Received: by 10.204.64.67 with SMTP id d3mr2806461bki.142.1247305184585; Sat, 
	11 Jul 2009 02:39:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123105>

Hi, hopefully a very simple newb question: "what is the command to
report the current SHA1?" - explanation below.

I'm vc-ing my MSc thesis and associated code with git, it's working
great for me. My supervisor requires regular submissions as editable
Word docs so I publish my source HTML to him as RTF. He adds comments
via Word & returns to me, I read in Open Office 3. This works, but
there is often a week or more between him receiving the doc and
returning it to me with comments.

I'd like to put the current SHA1 as text in the RTF so that I can
generate a diff from my current version before responding to his
comments.

The question then is: what is the command to report the current SHA1?
Note I never branch in the HTML repo, it's entirely linear.

Many thanks, al.
