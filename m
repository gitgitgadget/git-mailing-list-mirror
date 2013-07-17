From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv3 0/3] Switch German translation to G+E
Date: Wed, 17 Jul 2013 07:51:16 +0200
Message-ID: <1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
References: <87bo631odi.fsf@hexa.v.cablecom.net>
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@inf.ethz.ch
X-From: git-owner@vger.kernel.org Wed Jul 17 07:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzKeF-0003Oc-3R
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 07:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab3GQFv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 01:51:28 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:54769 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab3GQFv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 01:51:26 -0400
Received: by mail-ea0-f170.google.com with SMTP id h10so785767eaj.15
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4eKXod4HUvBn+NhhCA/QNAwSUZO0fDiisfboXskPGJA=;
        b=LV7G9pb2TUkR7Syvk/kBtGNe8uPpKSwaZeGZkC9akHTWwPb7SXfeARvzUJLeB7PY4y
         SZipr6tQlWtPoJLh6FbcBeiLJQKteiB6zewlG6eo4uxietPuqYglXGRiHhvxXgFK/yCU
         ob7+hJM4MzAC7H0Y8R7zYS3k0YRWbiW5HgNOY+Bdw7jVfQF3XELsmX8HrtbbFjYtzfhf
         besZGXd4rTPcUzSPqsL4TzA7aUPj/MzAMtcYnvIQvixygZiMQyxVdEkUKqBLmpUjJ/Lk
         37R/wkQakC2N0JWelLwuZU8A9d0c4fusVDMRmG+IR1sqZo2qWOQyS/9UzJarTXolKvBu
         ngWQ==
X-Received: by 10.15.73.197 with SMTP id h45mr4515721eey.146.1374040285733;
        Tue, 16 Jul 2013 22:51:25 -0700 (PDT)
Received: from localhost (dslb-188-103-254-174.pools.arcor-ip.net. [188.103.254.174])
        by mx.google.com with ESMTPSA id p49sm8042385eeu.2.2013.07.16.22.51.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 22:51:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1230.g519726a
In-Reply-To: <87bo631odi.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230601>

Thanks for your review Thomas!

V3 fixes a couple of problems Thomas noticed.

Ralf Thielow (3):
  l10n: de.po: switch from pure German to German+English (part 1)
  l10n: de.po: switch from pure German to German+English (part 2)
  l10n: de.po: switch from pure German to German+English (part 3)

 po/de.po | 1831 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 909 insertions(+), 922 deletions(-)

-- 
1.8.2.1230.g519726a
