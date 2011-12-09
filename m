From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/9] Re-roll rr/revert-cherry-pick v2
Date: Sat, 10 Dec 2011 04:33:59 +0530
Message-ID: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 10 00:04:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ9UQ-0000i0-Fr
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab1LIXEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:04:21 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34162 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1LIXEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:04:21 -0500
Received: by qcqz2 with SMTP id z2so2559662qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 15:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3iFiUmKfK5Y/vCYY+WZl7/c8jseGU1q8YQE9rASc2Z0=;
        b=ovsYuNrSlWKwxiabFbEN374yLm3iWeh+XbbPYNE4DBFR5moeRcgikUASdIS8o0ROdn
         S7w0jpJhgMhQxadUyR5YXo6vbZ0kfN6ByyeCyuWYNhnjC9M1xlwh54OgzJyShucQ2xPs
         v1h9KWl1C9xkS0Ixn2nZrmaDNwqDbFH0mbzhQ=
Received: by 10.229.227.84 with SMTP id iz20mr2309347qcb.164.1323471860192;
 Fri, 09 Dec 2011 15:04:20 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Fri, 9 Dec 2011 15:03:59 -0800 (PST)
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186700>

Hi,

I'm off on a short vacation next week.  I've already fixed up the
series in response to most (if not all) reviews.  If anyone's
interested in putting in some finishing touches, it's available here:

  https://github.com/artagnon/git.git rr/revert-cherry-pick ;# 195e68e

Thanks.

-- Ram
