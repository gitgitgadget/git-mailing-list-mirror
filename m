From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Are more and more patches getting lost lately?
Date: Thu, 04 Sep 2008 17:20:59 +0900
Message-ID: <20080904172059.6117@nanako3.lavabit.com>
References: <7vd4jk8r78.fsf@gitster.siamese.dyndns.org> <20080904083343.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 10:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbA7C-00051k-HA
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 10:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbYIDIVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 04:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756909AbYIDIVY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 04:21:24 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43936 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755336AbYIDIVT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 04:21:19 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 0CC00C8428;
	Thu,  4 Sep 2008 03:21:10 -0500 (CDT)
Received: from 8014.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id GNTCSXTP7P9J; Thu, 04 Sep 2008 03:21:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=K9jQKWBcuGRYWl7MSiTAZEHbueRP4cndIbl5CVPtp6JbLn0D1Try/vJFzxd/3fBbg+oJeYuR3My1h6FD30iWiDZIG80K3d3e8clYIaMnxEE3ww/JirmnA8H2D76BfQUd6T0puCE46xDlUTYTdOYDx/Xz2gVTMM3xEwMS4mnexMg=;
  h=From:To:Cc:Date:Subject:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vd4jk8r78.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94904>

Quoting Junio C Hamano <gitster@pobox.com>:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> I noticed that recently there are many patches sent to the list
>> that are left unapplied (and many of them are from you).  Many
>> of them look useful or at least promising to become useful.
>
> Geez.  Well,... thanks.
>
> Do you have particular ones in the list that you really want to see
> in-tree early, do you want all of them, or what?

Your "diff --quiet" and Petr's bash completion.

Also there are many patches that are from *you*.  Did you forget to apply
them, are they buggy, or are they in any way bad?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Thu, 17 Jul 2008 23:10:19 -0700
Message-ID: <7vy73zd8ok.fsf@gitster.siamese.dyndns.org>

http://article.gmane.org/gmane.comp.version-control.git/88994

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] feeding Maildir to git-am
Date: Tue, 19 Aug 2008 22:25:57 -0700
Message-ID: <7vbpzotfyy.fsf@gitster.siamese.dyndns.org>

http://article.gmane.org/gmane.comp.version-control.git/92963

From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] git-apply - Add --include=PATH
Date: Mon, 25 Aug 2008 01:05:31 -0700
Message-ID: <7vhc99h644.fsf@gitster.siamese.dyndns.org>

http://article.gmane.org/gmane.comp.version-control.git/93604

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
