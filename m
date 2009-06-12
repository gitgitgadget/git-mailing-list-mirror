From: Alex K <spaceoutlet@gmail.com>
Subject: uncommit
Date: Fri, 12 Jun 2009 20:02:17 +0200
Message-ID: <e4a904790906121102k51c502ech5fb7a1b1763c4657@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 20:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFB5M-0007te-Mm
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 20:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbZFLSCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 14:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbZFLSCR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 14:02:17 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:65306 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765959AbZFLSCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 14:02:16 -0400
Received: by bwz9 with SMTP id 9so2243341bwz.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nCFAAy6rsxb90MgMEHs/BTHWItkziHl1nezl7J4WQ0s=;
        b=R8SkphKblgtsNzv+ulQX74Sq0LTothiK38FQ/FZmVjFgdWUXqwwK0e90XoQD1DwL4i
         b2WBD9zXDJJPVzhjxX2pJYlpwkDemWDTmPAl1djHUrni2OsxUi87swHQkIhzPQ7vZtm8
         WlOMp0H5cJRAYSO6DkNVkDHd2E83UBQA7M/yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=XkpiQk0rg9Z53UvlK4yVRxb6/S5S6cDWIx9E6/tkywgDIyJQjHlx+R/0hL9vTidX66
         yCerGhftCRTuUfQZWrCERdw42VAc06QxAZ+8MSz9dhGyNxFqrCixo32HqUIzNEWULJfk
         C7FN1poSyXm/7sVNGvvsGt8P9sIoctUgyhzz8=
Received: by 10.204.117.201 with SMTP id s9mr3875947bkq.36.1244829737950; Fri, 
	12 Jun 2009 11:02:17 -0700 (PDT)
X-Google-Sender-Auth: 9684811afe551374
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Is there any way to uncommit but keeping the files as is in the
current working directory?

Thank you,

Alex
