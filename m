From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/5] Documentation/git-diff.txt improvements
Date: Mon, 29 Apr 2013 23:58:41 +0530
Message-ID: <CALkWK0n2V3LE6Vt2YQd5AKFkv5h0os=7MZA2GqwcrPQ1vEvE+Q@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <CALkWK0nVZHwSMS_gtisiAguNhAMnDpdWmAtz_OgzP93YZtYfHQ@mail.gmail.com>
 <7v38u9l2jk.fsf@alter.siamese.dyndns.org> <CALkWK0=aF2H4b9L32zvFQweYrzsJ-ZoBZ59TcECEasyy5TyvmQ@mail.gmail.com>
 <7va9ohjkv7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:29:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWspK-0001Dq-HF
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589Ab3D2S3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:29:22 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:51865 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758507Ab3D2S3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:29:22 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so7572201ieb.40
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Y8yNMvUUZqVp+UDT7WK5+CRVOKdmR8SRoLxVPRXVMNs=;
        b=oD8t9NHbMHz1sU7hQmgRVEXSBeToJuUxEYyYm/idKGMQdakXdajoE9k8xjUHpYZm0N
         w10Ghxnmg73xwT3+DFNlbqhMXiROr0lzcXic37VoLQNXjhjhW8lfSWnRB0p08F1Y4Oe3
         k4Lu3NgxGXXu81ZWTUeajfnaF5HS24hiVHWNOgjbn7Vq++5loluAhXWSd5A3ryOid+E2
         rEAn1ZqmeRNbUb5g9vdrm+LyjsTYcd4jCLgJwthpV2fEEwlkD8CvOWsZUUjLChUR+KSR
         eZnWEw1oi6crwuW7cETeCEbnZAmt7s1Ov0XuGHXpyyc/R/UdKAxJu1pzan2fYWtANE0g
         G0mQ==
X-Received: by 10.50.72.65 with SMTP id b1mr8166232igv.63.1367260161581; Mon,
 29 Apr 2013 11:29:21 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 11:28:41 -0700 (PDT)
In-Reply-To: <7va9ohjkv7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222842>

Junio C Hamano wrote:
> As far as I am concerned, there is no A~B issue.

You don't have to remind me about how hostile you are towards new
proposals.  I already know.

> Please don't let it take good changes hostage.

Those are my changes, and I will not check them in until I'm happy
with them.  How did this turn into a hostage situation?  I've already
signed off on my changes: you or anyone else has every right to pick
them up and merge them (even if I don't like them).
