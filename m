From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Fix two tyops
Date: Wed, 16 Dec 2015 13:24:46 +0100 (CET)
Message-ID: <cover.1450268673.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 13:25:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9B8l-0000yJ-7p
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 13:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbbLPMZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 07:25:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:58037 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbbLPMY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 07:24:59 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lev1D-1aYuFT2vrL-00qgZZ; Wed, 16 Dec 2015 13:24:48
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:TqzdbubaYbG6lQJL4zbxzso33WeN4AknwjK89j2PIT1euEZ8QXJ
 eaNpGQrgqB8+j/Vl/fEOFVCZTmEI6AyaqximskVfTBIItmBYs6uJ+QVHXA/75w+wq5GjtcO
 pOu/3vBEkxmRtkWxlOkg97TcYQi85TaHfKr1V0bO8AEJBa3fqAH5fHVZGCxiLNvWuj9fc0P
 JrmfNr18YfiOLPw7JEAjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4TW2zUB/k4o=:cNsdQcPJzv+A+GW3HeFsvN
 coxwYrTo80KDjbI1uZlyEGePk5wyJb1wxuK4yUQaan8WekP6GMchzKbzmEjiQ8eDD5HgPzJ/7
 Lh1QJZHT0otXpj9IOpKhZASbtDRcA+7IS6MwZL5WYImERk8iSCThDjcwrMwFwahwxu/ekdYtD
 k1sC2hTFovHIx47c/FNlNMYsIQxsHmQtg/GCpaNLWYja6MeDMFDUOcMz704x9OVyu/Fo6MACE
 NN2wYAKWORqwdIwpHUxcW3ABGTNOD8LRDTavmtREf8/owQ2kLx8eNJsBnr7iW1V1K+sF50p4p
 g8NFNZAnTvKuvoyVhRWl2zhjGErS+vLOa+fkGbupLnetFrZuh/ogr0RKa5rni8HZX67Nfk/tk
 FRfJwEd39Rp2aIrA53vFYMJwU08AXtBcaEdBcjbQPL7x7Ij2hEQ9wVxyZMSk/dcRmJ2ey5hxH
 kT5Tv77S8bPOuJPanZwDsfnIQ8jmHf0q00mSsfmhN86e1kQZK7Sh16uTTmHH9FJH+J/u4Yiks
 rbtTbqjtWGhdzMw0AwqDO3h8Cld02cmgW+YLZ4La+nqV2N7d/BZT3pVzpA7QC2HbjWU0YrFim
 xT5y63LN9TdrklYQOXWCN0I+dIHuS12Wf3d8kFLI8R/3W+s9eMwUB1P3eTptZMNboEhWH2W+m
 rN6d4k5Vp/SpWwmhTt8q69DMwOP3ZmFzGTFRjrBED0yejy1S8jNEXaa9hcwj9lkgqrfaUK34G
 xie/xgbtmMSyjReYprqksnYCQk4yPssRGrrucnE4q/eOdJtCHmWF9izeyXnTM1T9Ch9Vdhq6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282552>

These two grammar fixes are here solely to ramp up my commit count.

:-)


Johannes Schindelin (2):
  t3404: fix typo
  Fix tyop in the 2.7.0 release notes

 Documentation/RelNotes/2.7.0.txt | 2 +-
 t/t3404-rebase-interactive.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.6.3.windows.1.300.g1c25e49
