From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3 0/3] Switch German translation to G+E
Date: Wed, 17 Jul 2013 18:24:33 +0200
Message-ID: <1374078276-3510-1-git-send-email-ralf.thielow@gmail.com>
References: <1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@inf.ethz.ch
X-From: git-owner@vger.kernel.org Wed Jul 17 18:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzUX2-0006dD-OH
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 18:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab3GQQYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 12:24:44 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:51381 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab3GQQYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 12:24:44 -0400
Received: by mail-ee0-f43.google.com with SMTP id l10so1153783eei.16
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9WsGH1duCjhLPr9w2YPDM4WWyQaGjinfCVz8BgjXgOg=;
        b=We66rbTAKzH/xDtqUln6Ziq4LUKDT5zhQwPR1Lv75d3DKtdqNO0xwKwLwjw5mi/Dgr
         3k7cfwjW2mSPClhXvQgKYS+5MkoIxLUUHwI3D76zL01pma/fpCMA6b59PCc8m6YaC3w/
         8+JHXF+qjCO7prs4xzXKnahXwcukSBS0XAhURm+5HFFUFHZVsc61Ozv9AmU4zjDMwUhJ
         ilWfighK/GBOIhRqpEVBTGE84aYUGhcBxLPNsvRMFWJ9wRnCZ9FiLQC7Otz9voDHx6YI
         CrpwN33urpcZPtHM2xGRBUspfT7E+gUNc/aw12woxoU8xU0ebl7qdFQb1KTL7RbZ4ep/
         Lisg==
X-Received: by 10.15.42.72 with SMTP id t48mr7081828eev.105.1374078281557;
        Wed, 17 Jul 2013 09:24:41 -0700 (PDT)
Received: from localhost (dslb-188-103-254-174.pools.arcor-ip.net. [188.103.254.174])
        by mx.google.com with ESMTPSA id bj46sm11948930eeb.13.2013.07.17.09.24.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 09:24:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1230.g519726a
In-Reply-To: <1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230629>

This is a resend of v3 because at least one patch was
damaged last time for whatever reason.

Ralf Thielow (3):
  l10n: de.po: switch from pure German to German+English (part 1)
  l10n: de.po: switch from pure German to German+English (part 2)
  l10n: de.po: switch from pure German to German+English (part 3)

 po/de.po | 1831 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 909 insertions(+), 922 deletions(-)

-- 
1.8.2.1230.g519726a
