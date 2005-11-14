From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 0/3] Documentation additions and fixes
Date: Tue, 15 Nov 2005 00:20:01 +0100
Message-ID: <11320104011696-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Nov 15 00:21:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbncO-0008EQ-I7
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVKNXUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVKNXUD
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:20:03 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:62678 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751300AbVKNXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:19:59 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051114231958.SCJU21433.mxfep01.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Tue, 15 Nov 2005 00:19:58 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 31A23ADFE5
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 00:20:01 +0100 (CET)
In-Reply-To: 
X-Mailer: git-send-email
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11865>

While going over my Zsh-completion functions I found some options still
missing from the documentation.  I also found some problems with some of
the documentation, so I fixed them as well.

        nikolai

 Documentation/git-checkout-index.txt |   10 +++++-----
 Documentation/git-commit-tree.txt    |    2 +-
 Documentation/git-prune-packed.txt   |    6 ++++++
 Documentation/git-read-tree.txt      |    4 ++++
 Documentation/git-unpack-objects.txt |    6 +++++-
 Documentation/git-update-index.txt   |    2 +-
 unpack-objects.c                     |    2 +-
 7 files changed, 23 insertions(+), 9 deletions(-)
