From: =?UTF-8?B?SGFsaWwgw5Z6dMO8cms=?= <halilozturk55@gmail.com>
Subject: Feature Request: Passing a number as an option to git tags for
 displaying latest tags
Date: Wed, 22 Jul 2015 13:17:45 -0400
Message-ID: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 19:17:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHxeS-0008Vu-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 19:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934713AbbGVRRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 13:17:47 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37321 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934613AbbGVRRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 13:17:45 -0400
Received: by igbpg9 with SMTP id pg9so138633821igb.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JBUk0S7NIfnN6EKfs8YFQB5kELFxlsPRlzIP3SnlkkY=;
        b=kduGc9KcwcQ5i6YaViduOgI/ickXb2mTtSFWt2uTJKoIKHWiXwSNIcuQvkltXaxOkN
         sOZoON285SMVUQZ1QNZPmLP44b/epx/ta4zvU6t0NiWj/rvPiWMCFMCNvVWaB23gZYm2
         4pafU1P3OOaMYF4Geurbm3q0WVj/22b5SOI6jeQM705Mi2TTxgMgId7CiqnHhJo4L60f
         GY22NNslqaSpdVx21iKVMzjcnmk1an+VOsM0AEHyhmbpI+3V2NWsgX0d6Y8U7mUJfv1U
         9Kdj0AgjD999lD5ibY6Y297TlqovDWP51SrjYBmaoPB2DWL2r15A3bnW4dNlkCDL0+gW
         iX4w==
X-Received: by 10.107.158.197 with SMTP id h188mr6162904ioe.99.1437585465082;
 Wed, 22 Jul 2015 10:17:45 -0700 (PDT)
Received: by 10.36.132.141 with HTTP; Wed, 22 Jul 2015 10:17:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274447>

Hello team,

Passing a number as an option to "git tags" command should display latest tags.

e.g. "git tags -5" will display last 5 tags only.

Similar behavior to "git log -5"

Thanks,
Halil
