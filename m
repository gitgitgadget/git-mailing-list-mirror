From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [ANNOUNCE] Git v2.0.0
Date: Wed, 28 May 2014 18:42:14 -0500
Message-ID: <538674569a993_1a709413086@nysa.notmuch>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
 <53866e8562b7a_12a7a052f87a@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-fc@googlegroups.com,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:53:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpnfK-0008Fr-13
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 01:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbaE1Xxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 19:53:46 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:57339 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaE1Xxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 19:53:45 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so11587134obc.14
        for <git@vger.kernel.org>; Wed, 28 May 2014 16:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GGHw4mCv2yiGWGSB6EfuCYxy19ySAyU5VVrb2vdvbmI=;
        b=HMi7ceBOb/+5hvS0elIjW5jeIV+nuN3g5e9HM7z/r7yJYRIcmlsnvBTfIOJa+N2sBI
         e7m97H9vGOE0DxPvhKIuSIo71phTX6WcbW4u/SvPobSqVjGZvBqR6abzEapqPNwyz184
         d6jKpmzGc88e/aWp2Y207N4M/yhEnJjj38eKb4d4tvBOQjJG3UgT/KDmKzlEogt6iOzX
         4JVeHsfN0TKhKh1vlfmFWEF+plPqjAksWzbT1TuhMMBtlEEAo5HVrl/Fob3qv/WtGmlH
         FjbhBpZZl3vg5LThUyXaqDUhMv/8Cy/+RXfqSZVA4ESyWckj9ypTUnOlTCbcnRgeKnii
         /xzg==
X-Received: by 10.182.126.137 with SMTP id my9mr3633364obb.61.1401321225403;
        Wed, 28 May 2014 16:53:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x5sm70618510oei.16.2014.05.28.16.53.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 May 2014 16:53:44 -0700 (PDT)
In-Reply-To: <53866e8562b7a_12a7a052f87a@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250348>

Felipe Contreras wrote:
> In mail [3] you acknowledged my wish, and you said you were going to put
> stubs for v2.0, and you didn't. You also conveniently removed this mail
> from the archives.

My bad. You actually did it. I missed it because the commit is named
'Revert "Merge branch 'jc/graduate-remote-hg-bzr' (early part)', which
is not at all what it is doing.

So it's just the release notes that are misleading.

-- 
Felipe Contreras
