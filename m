From: Duy Nguyen <pclouds@gmail.com>
Subject: Big Java repositories to play with?
Date: Wed, 7 May 2014 20:23:30 +0700
Message-ID: <CACsJy8ArsQMBA3hq92u-6N9MCLYBgTRa_NYDm3QKjmKq25__oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 15:24:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi1pR-0002SO-H5
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 15:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933513AbaEGNYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 09:24:03 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:63955 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933397AbaEGNYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 09:24:01 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so961914qaq.23
        for <git@vger.kernel.org>; Wed, 07 May 2014 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=AgaN/eoJi89dSOkoRxySrVaSPmvDUcq/8Bh3OO6fL6s=;
        b=A65SNonIB9+l/RqucQnJ2xlmkKlhjc4p1q0MYMt9lxLwdfNWTeyRDaY+SxpFYAEk63
         L1SB+Rl+CEXB70rddYE4/24ae5gwgQvOyot4P1SWo+pXBJUSiDKt5ZMyN69UvCtxb2VP
         Cs2rfGU+CoMhBPMHd+hKPi06pvqTWqtV3nDqzkyhNhsXimAE6GVGe9Wba7NdhwFjQKq7
         DRFXJ6RG59AxTdpIw00acwC2MbH0l1qEbhpwbawNOZgKG7dgSTp09jXVUaa+PIDR/UoI
         jMIQyqYCJpXQ6irgOcw/z0ennAqFYGfGeZDomB8UHRAnScq2v2fABXrxt11oxNvRd4ZQ
         ms0w==
X-Received: by 10.224.47.8 with SMTP id l8mr65702009qaf.24.1399469040512; Wed,
 07 May 2014 06:24:00 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Wed, 7 May 2014 06:23:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248301>

I need some big Java repos (over 100k files) to test "git status".
Actually any repos with long path names and deep/wide directory
structure are fine, not only Java ones. Right now I'm aware of
gentoo-x86 and webkit. Let me know if you know some others. I'm afraid
my Google-foo is not strong enough to search these repos.
-- 
Duy
