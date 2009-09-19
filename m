From: Thiago Farina <tfransosi@gmail.com>
Subject: Release candidate period
Date: Sat, 19 Sep 2009 20:44:30 -0300
Message-ID: <a4c8a6d00909191644n131667f2uc7e59d0d56749c42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 01:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mp9fO-00056V-KV
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 01:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbZISXo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 19:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbZISXo2
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 19:44:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:7653 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbZISXo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 19:44:28 -0400
Received: by fg-out-1718.google.com with SMTP id 22so576135fge.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2009 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=FApsqj0DZ8wvRzBKvWc8a28PtxxUM75JNBBF9bJHLbQ=;
        b=m7VWVr/tK8yV4wHnyes2oU9DoL1NyvnubgGCU882wQOXljK4zNhakSgrOiuDXExDzM
         9+jWJqjsb8LhWGiWyOr8lL+mGLy3agTAfUi+/cMRLUY03MpDYK080BYPnAc1h9pIcWD0
         edeBRy2TazCH6Yunz7/roh3D9QBGOQWN48mUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=rUxw5dzCS0SWZ864BJo78oghGEqlCHJ3ii7DYZIE/LDXQyG8LUXNivrd33YWvck5oB
         zreGqfa81wt9HocRz6CEuLZz1CKy2ImvxxFi2Eh7qSukR/I8nuEw6yZuBFGCXny31pRU
         Xrmz11zURYbJuMNnvOIX79VshLXym8gpxdJfc=
Received: by 10.86.222.15 with SMTP id u15mr3094904fgg.33.1253403870919; Sat, 
	19 Sep 2009 16:44:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128831>

Hi Junio, I saw that you committed two of my trivial patches with your changes.

Thank you for committing my patches.

I have one more trivial patch that I want to send, but we are in -rc
freeze, when I can send it?
The release candidate period is not defined, no? The period ends so
when the mailing list reaches an agreement and agrees that the release
candidate is ready?

Thanks!
