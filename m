From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: When and how to to contact the Git developers (gist)
Date: Fri, 10 Apr 2015 15:40:17 +0200
Message-ID: <CAEcj5uW2Shh4QvtmenW2h6KXYUCoEe5bHYNv_HVFQgUit=cJ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 15:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgZAv-0006oj-9u
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 15:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113AbbDJNkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 09:40:24 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34420 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933116AbbDJNkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 09:40:18 -0400
Received: by lbcga7 with SMTP id ga7so13945284lbc.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2015 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=/K9dQ5HdQHa4rcSrN1KCa7A8bLjgbk5m4ENITP5Nz+M=;
        b=IqKbXrFj77Oxxbwbcn6UMzPCuf8HdZrD8XXB0Szsf8mNdSm5TUEwyci9bnmnyRV+wN
         9CtnHqbPwweZwzKJpVGpUzW0euSXZfsrPnEYEW0yUf5gmBy3RSCPwhEMj+029Pk/eGVw
         Nu6efJPDLtbtkwoj7ERA+/kz5ZHIxyT5C9mNyPpW/pxKsmMrDY808lCxQZn5ead7LOst
         382UU6UL/OuG6QUchSUgoEeqoCLDZzKwaLgxmblCt0Woo02zySY/U0Gcn8FuV5rD7JVX
         POvEaHbHd5X+U1soURYYdcoBi/mzstOA1lunDq4SR79AIRbW/Z24bN99w/WMnmzhW91I
         Fckw==
X-Received: by 10.112.131.66 with SMTP id ok2mr1486113lbb.51.1428673217041;
 Fri, 10 Apr 2015 06:40:17 -0700 (PDT)
Received: by 10.25.159.10 with HTTP; Fri, 10 Apr 2015 06:40:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267011>

At the Dev Summit, I mentioned this gist I've got lined up for
whenever someone should consider sending an email to this list:

https://gist.github.com/tfnico/4441562

It's a handy link to share in some encounters, exemplified by Konstantin here:

https://groups.google.com/d/msg/git-users/Md72iVvPHqw/Zi3yFIRrR2AJ

I see that Peff already improved the git-scm.com/community late last
year to cover some of the same points, but it is weighed a bit
differently. Perhaps someone here would prefer to use my gist when
redirecting people with "user questions" away from this list, or
inspire them to write better bug reports.
