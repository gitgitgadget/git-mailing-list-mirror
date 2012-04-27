From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Subtree in Git
Date: Fri, 27 Apr 2012 11:48:31 -0700
Message-ID: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 20:48:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNqDe-0000SF-Ma
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760762Ab2D0Ssd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 14:48:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44929 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760660Ab2D0Ssc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 14:48:32 -0400
Received: by yenl12 with SMTP id l12so631168yen.19
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=G5T52nT7CNQicQLYRs/xdKeuqMUiFCJXjuOo5lj7FL8=;
        b=leQE6OtyMyUS5vdl2PqiCjZEvWEWwSRhcEcCS8I93IHMAxpf5Hn1XCT8O2JKGLLVCN
         ntpnsPBijVwa5JmEDVjTScFSix4MkeW1iwrYDewNekVEc/gB+k37MMaBqNsvhhzpXFGP
         cfw8h5f4CtWd9Ws8LPsCz0IiMsAcnvbB5dTMF7AHfx0oVIjLn7oCfDsihyQH7M5JG5i0
         JjkZlC+gy+L9ghfGsljiQfHZkboNwT1FEAX+mIIdr8oqMv+9OMClwqfdCZm31KMjq3Bq
         I2Zpy0N/Iia6vtu2PSusnTlHdhb/XI/xL8qT42fA2phVIvLZJcM0UNCGK+Aw7fcFUiWI
         y1pw==
Received: by 10.236.168.41 with SMTP id j29mr12383548yhl.24.1335552511936;
 Fri, 27 Apr 2012 11:48:31 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Fri, 27 Apr 2012 11:48:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196481>

Hi all,

Do we have an idea of when subtree support will be a part of Git core?
I am aware that I can install it separately but I'd like to know if
there is something like a timeline or a target Git version number. And
"no", is fine. :-)

Cheers,
Hilco
