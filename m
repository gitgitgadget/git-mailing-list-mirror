From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Has Git 2.0 started to be integrated?
Date: Wed, 16 Oct 2013 14:58:20 -0700
Message-ID: <CAH5451=8BYN-Jsxsbw-3R36Kix__1kfW7r3_dtSbNhg+ukyNfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:59:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWZ7T-0000zH-O7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772Ab3JPV7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:59:02 -0400
Received: from mail-vb0-f44.google.com ([209.85.212.44]:35721 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3JPV7B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:59:01 -0400
Received: by mail-vb0-f44.google.com with SMTP id p14so696430vbm.17
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=t55ibwZyIEy6akQsM2i5gXH1dJfL3tCLQMVxdm/Dhn0=;
        b=eCFeC0H/h2qZr0Kuva7tc7VEvVLUNiKNRHJfaFJo3QcbvSsR/xAaOsSWYBvzCIcVNM
         WfICPmmStCSBsjTTxyJ4HvNbXYITn11XxsNSAIzQdsmJNC/roUKSdWsUVvwetw5aD+Bq
         Rh9suaXv2TclHXZvUe4EX/tAxL8Fe0JbXY+TB4O7EiqbRJoPXPB+Ldq8YjXdYWE/DhgW
         w7PLKiRo6kbR87tOLIZK9w8gJIdAFRfK/u3Gg2Qd9dVMfoZKlesBZ44z7fP5ZP6vSUHt
         hcqcVq6D5gy0IAIED9HZv23hC0F/O9b+NGjeyeIiZJGe9wEqEloo8e+3P7LlJeb2bTz6
         w9Uw==
X-Received: by 10.58.55.227 with SMTP id v3mr4163341vep.16.1381960740185; Wed,
 16 Oct 2013 14:59:00 -0700 (PDT)
Received: by 10.220.58.197 with HTTP; Wed, 16 Oct 2013 14:58:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236275>

There has been plenty of comments lately about how certain features
will be released in 2.0

Have these features been tied together anywhere yet?

If not, when might such an integration branch be created? Would be
very interested in seeing how Git 2.0 plays, even in these early days.

Regards,

Andrew Ardill
