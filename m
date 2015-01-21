From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 0/2] Fix typos in various places
Date: Wed, 21 Jan 2015 15:15:41 +0600
Message-ID: <1421831741-28895-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:15:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrOB-0004B9-T0
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbbAUJPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:15:48 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:36868 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbbAUJPq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:15:46 -0500
Received: by mail-la0-f43.google.com with SMTP id q1so23779027lam.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 01:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RHUxUuIyFqC53/xj9PCrHg7YQKxkqb5i01HV2f/oZz0=;
        b=T9GGkPiY4V9UlbWTvz7K0rahAndcTmBHgbspp88uNgoYOiT2l1k6LjdFMDuNUjjsZE
         26qt9dK+EMVbqHfNvxY4j+8aNVr4VPzKKMJ8aZd+54y+lGm7MZdaLVYK91pFoc29mK2c
         u4MAFCNR8BdpOlTSEKp2ecMIwjvawruo8GjUjeMTl5IbeM8RGDNFg2CwAw41nPlVh6eE
         HRWJ3kQ1gFVA1fsgxSZNRYVpVYP5JZn3nAB2yc521WvvNBJvjJgKzIlVglKg3Ysg3tUz
         Hu8Q6piguh03RjXs9DXgFQb9RTITy/rxfYJ1oNshMI9G/j9ekn27EJbvXBl9q82HNuWM
         RnOA==
X-Received: by 10.112.12.134 with SMTP id y6mr43181135lbb.34.1421831745035;
        Wed, 21 Jan 2015 01:15:45 -0800 (PST)
Received: from localhost.localdomain ([147.30.53.164])
        by mx.google.com with ESMTPSA id v8sm5330242lae.6.2015.01.21.01.15.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 01:15:44 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262724>

These patches provides two minor typo fixes in pack-bitmap.c and 
t/lib-terminal.sh

Alexander Kuleshov (2):
  pack-bitmap: fix typo
  t/lib-terminal.sh: fix typo

 pack-bitmap.c     | 2 +-
 t/lib-terminal.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.3.0-rc1
