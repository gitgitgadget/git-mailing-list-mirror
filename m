From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On a personal note
Date: Fri, 04 Sep 2015 09:10:31 -0700
Message-ID: <xmqqy4gmf9mw.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.1.00.1509031156510.29350@s15462909.onlinehome-server.info>
	<20150904130801.GC25501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git-for-windows@googlegroups.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXtaU-0004fS-IU
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 18:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760241AbbIDQKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 12:10:35 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34495 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759976AbbIDQKe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 12:10:34 -0400
Received: by padhy16 with SMTP id hy16so26114781pad.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eirm+jcsPj4p4npMjOlZsjdCL9oNwieLl2ad+WogdDs=;
        b=uEL+LIMvcHA6xsQgu2VQOLJmfRXvV6aMwlM5xZthoujIKxSgRysE561py5gBEy4Woh
         k7hv1hqi84YZLAiZCX6aP+86QC3zeXpCf57lrkoVnxy76XW22yIPFmLmGDcE5UqDddwa
         ECfgfwLkMiv4BRBocOuQc5BfRZUUA/zKEuXgEgVYjWTaKqZDQP0GUJzCjsCZrRFMZW81
         lKQ47U6EYD94BKbb2hPfEGp7mN8cEMe0CaY8ol8U8UB68zT1wEyIHgQYN0TDZhAm8Eu6
         Bt5XboGKNNZ4AW6I3bDznLsMr9L7dX0o6f0pMuPi0KcIeCjgaHxK/ihputLWsWku73gB
         L9yg==
X-Received: by 10.68.142.130 with SMTP id rw2mr9752238pbb.107.1441383033781;
        Fri, 04 Sep 2015 09:10:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id e4sm2999063pdd.45.2015.09.04.09.10.31
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 09:10:32 -0700 (PDT)
In-Reply-To: <20150904130801.GC25501@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Sep 2015 09:08:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277320>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 03, 2015 at 12:00:58PM +0200, Johannes Schindelin wrote:
>
>> In short: for users and contributors of Git for Windows, nothing
>> changes. Except that Pull Requests and issues may be dealt with more
>> swiftly, and that I will actively work on keeping Git for Windows more
>> closely in sync with Git proper.
>
> Yay. :)
>
> If anyone had told me in 1999 that Microsoft would be sponsoring
> development of an SCM started by Linus, I would have thought they were
> crazy.

I probably wouldn't have said "crazy", but I think it is very likely
that I would have uttered "embrace, extend and...".
