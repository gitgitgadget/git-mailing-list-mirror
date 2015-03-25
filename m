From: Shanti Swarup Tunga <b112041@iiit-bh.ac.in>
Subject: About GSoc idea.
Date: Wed, 25 Mar 2015 20:36:41 +0530
Message-ID: <CABJeaiomjkc7dEpT8i0Ecxh41fjOdZFm+du=uf7azq1nJitiuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 16:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YamtL-0005b5-W5
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 16:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbbCYPGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 11:06:42 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35645 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbbCYPGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 11:06:42 -0400
Received: by obcjt1 with SMTP id jt1so21593317obc.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 08:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=6hpnRmGEtfLxrvm2wGMGX/DpNsjjSQhrQaRU5JmNbTI=;
        b=jIFobZsx4e+T7XxuB5DfHXxlte1OJ4IpO9dkYVHeE05XD5lp7puASh5p0BTihpiPg7
         JucCidwflzMxICj9wByCcsbz9ACnZ5NMmxDpLKQZaBXTQHvv4KOvL/9FsdpnNKeT5OLs
         c7KsKpJ6BN38pS1zKw2F3Lr9gdjzxUvWhwJh9VkT6lCa4jXDvrBAGRdH0Gr02x14Xque
         Ryfz2u8N1u1ABVVT+IKSc8R4qa43FRGOvjLxJiqEfVsTbRUihvutKDGr5fxoouEsIELu
         uTTIivPsFnR2oX63FJqymGhbaoE+XhouZU2P29PSePMPkw+WjmvUV3NgM+/Vv9+/YeQ1
         D/TQ==
X-Gm-Message-State: ALoCoQkP5lltN4wwVKu4Ww5xkJdBCJF8gUEN6Ff+myscGy6bDcsxJc/KSDzvv3sv8VjBqIJ7BDB3
X-Received: by 10.202.220.70 with SMTP id t67mr3349024oig.102.1427296001338;
 Wed, 25 Mar 2015 08:06:41 -0700 (PDT)
Received: by 10.202.73.148 with HTTP; Wed, 25 Mar 2015 08:06:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266281>

      Hello
            Duy Nguyen and Stephen Robin , the two developers worked
on converting git-pull.sh to C code . But in the idea page it is
written that we should start with git-pull.sh. Should I worked on
"git-pull.sh" or other shell script for the GSoc.
