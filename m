From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Make it easier for new contributors to come to grips with the project
Date: Thu,  8 Sep 2011 16:47:58 +1000
Message-ID: <1315464479-6876-1-git-send-email-andrew.ardill@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 08:49:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1YQ0-0001z7-6z
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 08:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab1IHGsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 02:48:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49782 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab1IHGs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 02:48:28 -0400
Received: by ywf7 with SMTP id 7so394923ywf.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=B4lqV8ByyE2zlILCUfkxTKw4f6QPLrvg/1FBhEMDBeM=;
        b=LTPXbrcW2yRR4elH2U4MI/JUejYCjcNjfQaHMql7PGWd0LigfU8cPX5CRPQ0ufE9eQ
         gNkiUZcc/KpcV2pSERJObmdxSoUakdqMZbSuXiGpsjFfkUAHD8LBsRbGzeY+ULj2wrIy
         WNmEAPQnkHjv6bm/u3J4revW3RgyUgmKeGjXQ=
Received: by 10.236.181.137 with SMTP id l9mr1776288yhm.56.1315464507610;
        Wed, 07 Sep 2011 23:48:27 -0700 (PDT)
Received: from localhost ([59.167.165.193])
        by mx.google.com with ESMTPS id s48sm2872297yhj.7.2011.09.07.23.48.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Sep 2011 23:48:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180943>

Something that has been difficult as a developer looking to contribute
to this project is trying to understand how everything is organised.

In particular, working out what 'pu' stood for took quite a long time.

Following is a (very) simple patch to the README that will at least
send potential contributors off in a useful direction. I know I would
have saved much time if this note was there when I started looking.

Potentially, the wiki and public website could be updated to provide
similar links and start-up hints.
