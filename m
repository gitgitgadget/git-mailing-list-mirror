From: Neven Sajko <nsajko@gmail.com>
Subject: [git send-email] Less secure?
Date: Sun, 24 Apr 2016 22:54:52 +0200
Message-ID: <CAL+bK4Ms5WLSiWEPhXOX2i5T9UdcaZyD+kaTZpVsd0NZBts+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:54:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auR3R-0006rm-NK
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 22:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbcDXUyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 16:54:53 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34813 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbcDXUyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 16:54:53 -0400
Received: by mail-yw0-f182.google.com with SMTP id j74so152560235ywg.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=zoAt7G7RtGeno5+gsgeQDuctGEzJwj+10UiHYT+N6XY=;
        b=p01PguRNFOn9qgX/FJbeUN1CKZHpvdAITs5vFb0Y2bA03ahEMR0TIHPTHVcG9LC8lU
         3YOrasdzmMgkR6QlvGMJ88Q7+SMnz7Nv0EVquGv9vGkJy5A4U6G/E/K7GIFDbVYMwzMG
         F924XzmLBjir9Ek5kH2qnjIVfddxkbnPKeqsGQSn5lLWabNUOC2w3k0H4b+YxoF3f9iN
         KGmzL3I7vXJJDmzJ6f++lONOctLO4UotVfqWQdYI1jpW1Ne1VcPWwEBrJht4UBuD7Y6M
         2Os8Trh4CD98OQxVZh62MK4JXJVJ/h7tuN99++He+S9K+ZMISSe8UGNzFP3XP40LSucB
         EQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zoAt7G7RtGeno5+gsgeQDuctGEzJwj+10UiHYT+N6XY=;
        b=SDPUQegrKfgaMGQU1QVM6DFmuzBOcMiOb5CprazxZy4BrIH3DNo1m/608eAgUJf1WJ
         NitHrl/0pcak7NhcK5XFQXh1AV+1bHaOQwhHgnpEoKB7qLlzDUYlnRqjjUOY+jH1mCTh
         +ob+72GN4LbUaMYAuU0EUdLP8dxNLdF9Md85iaQ6KnOzeteo4g/4BPH4MsfTWM/gFiMA
         BD8r6LQXrCmVKZ0eJ2bLpSH7fcR+VlaGiKbSFl5dNV7LL9tg5FrJycc4o2LuKNPFH9YE
         zOR7AgfX+f9ujBRoAX0ZzYV9cD3UTZO2lSfJtVDvRRPuzRCkpx19Bxn6oY+OhzCsd+gn
         9ieQ==
X-Gm-Message-State: AOPr4FUPfmE9dEmIG/Cybrjt80lk/ZAkmm7RAwdqCzVy22jUCIxZFb1nCUNEKr3IkY+WfWOvqCpuKZByF6/q9Q==
X-Received: by 10.37.113.132 with SMTP id m126mr14229ybc.180.1461531292245;
 Sun, 24 Apr 2016 13:54:52 -0700 (PDT)
Received: by 10.37.216.140 with HTTP; Sun, 24 Apr 2016 13:54:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292443>

Gmail by default doesn't allow usage through send-email.
They say that send-email is "less secure" and that enabling it
makes it easier to break into my account.

Is send-email really less secure than the Gmail web browser
interface?


Neven
