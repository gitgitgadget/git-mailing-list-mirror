From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: put THEIR commits AFTER my commits with a single rebase command
Date: Thu, 18 Apr 2013 10:59:00 +0400
Message-ID: <1279652941.20130418105900@gmail.com>
References: <1928280357.20130418091807@gmail.com> <CALKQrgeYrsOOR9z+khOkGWhy38LPXwHFo9wf8RrZr3LsM3zTAg@mail.gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 08:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USioS-0003rl-Hj
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 08:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965999Ab3DRG7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 02:59:08 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:32854 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965991Ab3DRG7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 02:59:07 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so2251682lab.9
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4eXqs0kDsZvAdTT9+BHKQ/fYBrL/+6yg7KJzbJ3FfO0=;
        b=dC6fPVOXqn+ip+5IrwDj4RXbiioN6opkN/60PtRp5weYGmxmDH+QPc5u4kfGtt/RR1
         4E/RHS7PUy+aby2zNonZie4ax8iAlsKTi6sYdAty4E9oNwgoyqpw4f1ipc90bLreue1R
         zE1qd2+K9qEVXYiCLbVH0GNXcQgdruVmPy7ML+K928acVN5NxYguwKjMbd/ZymhnAwR0
         WmlKn2te/4sSgq0QAaU2b96jZjCp8G5acQW9J6Pxfcxqkucz/x8OZRDQElLXvaCDlB9z
         mY66T1NaI6IwYYWWKLDchMdpC+0gt4rZ8cz+QBqnSO7JW9qOKfbGDUdK0x7RUcbchk0y
         ss2w==
X-Received: by 10.112.163.6 with SMTP id ye6mr5111034lbb.59.1366268345939;
        Wed, 17 Apr 2013 23:59:05 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:84e0:55a3:4150:1bdd])
        by mx.google.com with ESMTPS id f4sm491325lbw.6.2013.04.17.23.59.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 23:59:04 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <CALKQrgeYrsOOR9z+khOkGWhy38LPXwHFo9wf8RrZr3LsM3zTAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221615>

JH> git cherry-pick master..origin/master

Thanks Johan.
