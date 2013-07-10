From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv2 0/3] Switch German translation to G+E
Date: Wed, 10 Jul 2013 19:54:47 +0200
Message-ID: <1373478890-8480-1-git-send-email-ralf.thielow@gmail.com>
References: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Wed Jul 10 19:55:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwycD-0004ZD-7t
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 19:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab3GJRz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 13:55:28 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:53206 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab3GJRzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 13:55:07 -0400
Received: by mail-ee0-f51.google.com with SMTP id e52so4984943eek.24
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fNlF/fTXQCMtBrzwQKD3J3X71jujFopGh61RujWJj4k=;
        b=TS7LLM+k5EMOMaagpsTWDY5WnbqE73YQl/+wFAsFzwmYC+qCxJZ4tifyge9/2Du/qr
         yJ7zFEEskUWTHsc8/LQ6O09ef/QokhJQoS+eS9m/nWcEnsOZWlQNpXzDMBaBZqI+h21m
         ZeKjzvu4BQ3ZaKYQ1JIPBoNzXfquV5O8X160aFyXQAUrqNLxPpdvkdVNZk0exf9R+PZY
         dIpCHs+UJnac3f63E2e/YT+0GDardC97JOLZOfEGYMUmeSvyuKR5ET+hH5JYWg1s7YOg
         aQlZeF0i4yVvVzlQJji4Qyzt14a6isz1OOJ2/px1KqhfPAbpO3piQc0vJOiAhT3jgLtU
         uy0w==
X-Received: by 10.15.90.139 with SMTP id q11mr37473343eez.137.1373478906014;
        Wed, 10 Jul 2013 10:55:06 -0700 (PDT)
Received: from localhost (dslb-188-103-254-174.pools.arcor-ip.net. [188.103.254.174])
        by mx.google.com with ESMTPSA id n5sm61771935eed.9.2013.07.10.10.55.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 10:55:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1230.g519726a
In-Reply-To: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230061>

V2 corrects a message in the second and the third part.

Ralf Thielow (3):
  l10n: de.po: switch from pure German to German+English (part 1)
  l10n: de.po: switch from pure German to German+English (part 2)
  l10n: de.po: switch from pure German to German+English (part 3)

 po/de.po | 1796 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 892 insertions(+), 904 deletions(-)

-- 
1.8.2.1230.g519726a
