From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 14:39:12 +0200
Message-ID: <4D908170.2020207@lyx.org>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 14:39:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Bj4-0007gS-RH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 14:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab1C1MjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 08:39:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53587 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab1C1MjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 08:39:12 -0400
Received: by eyx24 with SMTP id 24so1131036eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 05:39:10 -0700 (PDT)
Received: by 10.14.16.100 with SMTP id g76mr523075eeg.168.1301315948014;
        Mon, 28 Mar 2011 05:39:08 -0700 (PDT)
Received: from [145.94.168.61] (wlan-145-94-168-61.wlan.tudelft.nl [145.94.168.61])
        by mx.google.com with ESMTPS id q53sm2738754eeh.11.2011.03.28.05.39.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 05:39:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170122>


> Why can't bisect just do the right thing here and accept that your
> more recent revesion is the good one, and the old one is the bad one?

There was a recent discussion about this:

http://article.gmane.org/gmane.comp.version-control.git/165433

Vincent
