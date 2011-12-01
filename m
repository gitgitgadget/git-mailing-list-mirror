From: Ivan Dimitrov <ivand58@gmail.com>
Subject: workflow for component based design (newbie to Git)
Date: Thu, 1 Dec 2011 13:29:10 +0200
Message-ID: <CAO8zR6N_kxQHA+Z=ruA5T8cc1A6km8Y3RouXib6oRXPWHzfA6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 12:29:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW4pI-0005c3-QH
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 12:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab1LAL3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 06:29:11 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60883 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab1LAL3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 06:29:11 -0500
Received: by vcbfk14 with SMTP id fk14so1311961vcb.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 03:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1pFbx2jf+rtIC+UXonDIRo1Kert2cTfyal7Kjd7fYh8=;
        b=x3p44Bok4mr1avNXSvogV5HPETEs1KFPaRIvPGHDipP70nmzuUdacuqRDUJ0xFwoyf
         vVMxYy4xj+hYgo2kLWYmMgoMwUUXkmKuZ4rnF7fv9dEyRRE7pTWazOSr4kZd6Iof6hnB
         5Y0eHytDr2iGw6TOkClIKB7M0R1eWZ9P0y+9I=
Received: by 10.220.154.5 with SMTP id m5mr1126865vcw.199.1322738950086; Thu,
 01 Dec 2011 03:29:10 -0800 (PST)
Received: by 10.220.203.194 with HTTP; Thu, 1 Dec 2011 03:29:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186168>

Hi all,

Please forgive me for asking this, but I can't seem to find
instructions anywhere.

I'm planning to migrate from Serena PVCS to GIT, but I can't realize
how to assign a label only to particular files (component) and how to
apply the promotion model to my project with GIT ?

So, in general, how one can handle a project with component based
architecture (and workflow) with GIT?

Thanks in advance.
