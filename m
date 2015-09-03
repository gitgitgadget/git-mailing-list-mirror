From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git dockerfile.
Date: Thu, 03 Sep 2015 08:59:52 -0700
Message-ID: <xmqq1tefmr2f.fsf@gitster.mtv.corp.google.com>
References: <CAAhzzTbvS_FewTC9Dz2XzOMXeKe405qHhvAGtcsVjXLK0kOehg@mail.gmail.com>
	<CAAhzzTbtEr3NnJtXS4zrFmo8+Hm-2qt32XV=3UfWpZP+KFT2OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Gawade P <gawade.oefp@gmail.com>
To: Atul Sowani <sowani@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:00:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXWvs-0002zg-KY
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986AbbICP7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 11:59:55 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34354 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992AbbICP7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 11:59:54 -0400
Received: by padfa1 with SMTP id fa1so8256099pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HcNc4SRkiGyFLqOA5kqfIad7+HVgi9SvHmGAu8m+gbA=;
        b=CLGO6nvjME1rjxux0poQHWNlpJ9w2mc0x++uxvpsv5EfOc0yOtiDpm+hg4PWzynOcy
         ksNtmT+jJ4JeuogDc7so7LJT5yqeSLBIToM8zN3E4G9KDI3shrkp7ml9RrgVydt0Jh7Y
         XbKPWdK+crSY+Pb+6edt11B7/G9qZUS7JEU3w4kPTzxErAvTEcdIC71G/o06SJp+D3KJ
         j7rNR+1S4fekcKd84susjUTX3lSJo6zZzjEMG/T2o8NqgaBhugaGi+Nmi0MMPjmEDhu6
         R+5fQ/cskOaZuCE/ihBkZP52h1hLIU1Tx3BaFejcbRF3D3jkD/BtBhtZhuAD4y/xRFos
         KShg==
X-Received: by 10.66.142.166 with SMTP id rx6mr68579643pab.25.1441295993494;
        Thu, 03 Sep 2015 08:59:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id gh5sm25702209pbc.87.2015.09.03.08.59.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 08:59:52 -0700 (PDT)
In-Reply-To: <CAAhzzTbtEr3NnJtXS4zrFmo8+Hm-2qt32XV=3UfWpZP+KFT2OQ@mail.gmail.com>
	(Atul Sowani's message of "Thu, 3 Sep 2015 13:55:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277214>

Atul Sowani <sowani@gmail.com> writes:

> Hello!
>
> Any help/pointers/advise regarding my request about dockerfile?

[jc: "Gawade P" Cc'ed.]

Perhaps you can learn to ask the list archive ;-)

Going to http://news.gmane.org/gmane.comp.version-control.git/
and then asking for "dockerfile" in the search box at the bottom
finds

http://article.gmane.org/gmane.comp.version-control.git/276504/match=dockerfile

Clicking on the "Subject:" line there would show the article in
context.
