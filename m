From: shawn wilson <ag4ve.us@gmail.com>
Subject: push fail
Date: Mon, 17 Mar 2014 09:06:56 -0400
Message-ID: <CAH_OBie+KrSjtqLinbv8sJAOCu26j8xVzBQJHdHTB44V07GsXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 14:07:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPXGF-000515-J3
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 14:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbaCQNHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 09:07:18 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:50624 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895AbaCQNHR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 09:07:17 -0400
Received: by mail-vc0-f170.google.com with SMTP id hu19so5808465vcb.29
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=sOjdtzDWL2bvYGO/sGGllrnFkXZRnjXBe0m1YUZl2cY=;
        b=p5p7Q0BFUYJeR7RfnJrBHlHOWyXheVoX8iAExmoi4uiw0YjwMRS/HPaQdnb0e64GR/
         l2Rmv0uDtAO5Mo9PpU6BDPUUjzrUOaIP3W8ArTl0O46ILtC614v9St5GY8yi79pr8w5j
         IDIkmlNZNV47vGG/aBFW1GZshXuYTo3uauJwbP3+SNvI1OS/jt4zoYrSxp3Bewt2wX9d
         GNob6HK2kYBQJq1jE9SQY6TJL/4p0hofFmH7jHoUlnRXe06dBZZvKiNWrujHZa8X4vCB
         HaxrNwXpEhZobmSeMmSH7SQ/8+pWBEDkNWLGVhpvZ1txZc6IOC72yycvevKGaetn3O7d
         D2zg==
X-Received: by 10.221.74.65 with SMTP id yv1mr344628vcb.31.1395061636667; Mon,
 17 Mar 2014 06:07:16 -0700 (PDT)
Received: by 10.52.227.233 with HTTP; Mon, 17 Mar 2014 06:06:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244249>

How do I get more info here (and hopefully resolve this)?

 % git push
To ssh://server/foo/repo.git
 ! [rejected]        test -> test (non-fast-forward)
error: failed to push some refs to 'ssh://server/foo/repo.git'
