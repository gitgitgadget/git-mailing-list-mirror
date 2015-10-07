From: Junio C Hamano <gitster@pobox.com>
Subject: The tip of 'next' rewound and rebuilt for this cycle.
Date: Wed, 07 Oct 2015 14:33:20 -0700
Message-ID: <xmqq1td6tlcv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 07 23:33:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjwL0-0001vm-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 23:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbbJGVdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 17:33:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36517 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbbJGVdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 17:33:22 -0400
Received: by pablk4 with SMTP id lk4so32206973pab.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=+l30xZPoAKXx3TDnQuWBHOZJb6c5n9BxboKgmmrx5RQ=;
        b=BthOmnBmDfg8zSpwT7AqJLBW8mv6jbQ0wp83sXRkRB3HNbrMR/mKIvEUbEr+bhEdr/
         PdEyZCzwWEcp50zRf+VHp9mR0zI2BwfMhzufMHKTl3Lst6W0GNqwslpkAXul2wF+oSny
         t95JNEJfTNSkEto9P7ABULwZl3jSUw3DjAND5lIMMpUbgxE7zzkub8WekYhhTNKnmxFS
         a20r+Fe4lpTFgc4ja53jPtJKCsBqPvgCXmsQd1MTbVlWjo0GFnKuFlOq+lOdd00QLEXw
         1ylbL5btdoRM+5CwHN3FcNvZS2t+CBsikJvg4kCVb2OmJgsgeds0o7ujGco7ve7oJqnQ
         6HFw==
X-Received: by 10.68.105.193 with SMTP id go1mr3504900pbb.59.1444253601786;
        Wed, 07 Oct 2015 14:33:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id dy8sm27820905pab.38.2015.10.07.14.33.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 14:33:21 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279202>

I plan to start merging the topics that have been cooking just above
'next' down in the coming days.

Thanks.
