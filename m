From: Walther Bauer <2313218@googlemail.com>
Subject: Indelible actions only
Date: Wed, 29 Jun 2011 00:18:36 +0200
Message-ID: <BANLkTinUSoB=GGe+qXpPh+WFgRU2S2jnGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 00:18:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbgcF-0002dw-W0
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab1F1WSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:18:39 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:37573 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab1F1WSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:18:37 -0400
Received: by fxd18 with SMTP id 18so626262fxd.11
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=J3mNB1KS//r1r5Q3X9Q5kPjrToYJUvZAM9AFpnZ7PNo=;
        b=H8C7rH2UTUF1g3+kjJ37Yf6SMm1jMkt/YqVowug7hRnCkzBA5QxKWEpWWjKo04KNHV
         KIYcDjFyrA9huy6z5Xae6keEaZ8Ukw841wQtWE66iiOrrIUxbGCW99SbI2j4vb9CAauG
         B5YeKK0ZLlrdBK1UP1cGkhdt0L5iU3BgvyMjI=
Received: by 10.223.143.20 with SMTP id s20mr140603fau.10.1309299516519; Tue,
 28 Jun 2011 15:18:36 -0700 (PDT)
Received: by 10.223.73.208 with HTTP; Tue, 28 Jun 2011 15:18:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176424>

Hello,
how do I configure a git repository in a way, that no modifications of
existing history (eg "commit --amend", "branch -d", "rebase") are
allowed?
Regards, walther
