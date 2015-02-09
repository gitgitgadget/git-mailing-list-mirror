From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] gitk: Remove tcl-format flag from a message that
 shouldn't have it
Date: Mon, 9 Feb 2015 14:36:51 -0700
Message-ID: <CAMMLpeTvtzPuiQJVxAx-Ja4JsoUxih5azMaN7_RcLvajny6A6g@mail.gmail.com>
References: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:37:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKw19-0004KP-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761383AbbBIVhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:37:14 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:43349 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761313AbbBIVhM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:37:12 -0500
Received: by labhv19 with SMTP id hv19so16315314lab.10
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 13:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=STfLM5BdOT70v3/mPG7sv8N9bzx45lqLdk7LHfak1Uw=;
        b=zU5lV9bhfsqLvI/Y9gf6cnBZp6rN/KtipjPme2weqB5NSrcpS1NEV1vWpqq9S7JcbJ
         gV4LJTt2TDYdnLKmO1co6//TmP3BI5f61z0APbMhayuVNkckmDPtTaczqWXRErrSVt5c
         WOmZFc4hWfTgtJaF3x8dvY2KoE/vvT6CULqLvzRfalkINcSFlmUf0K/DW4WQdtGORF8q
         8HDytFnt3rL1WcEMqdBKjPqrISW7cZrZZYEkcKFoW5TDqWW2dAPFdZJad34sSLAf5duD
         9eMfVQ8ko2duH8LOC7OMFELruqDqIuQdHKCEJ5kqIX4KlHD8PHlD9nY8oIyVmZ9eY0uu
         o+KA==
X-Received: by 10.112.13.38 with SMTP id e6mr7757621lbc.31.1423517831622; Mon,
 09 Feb 2015 13:37:11 -0800 (PST)
Received: by 10.112.146.42 with HTTP; Mon, 9 Feb 2015 13:36:51 -0800 (PST)
In-Reply-To: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263605>

Hi,

This is just a friendly reminder that this patch has been sitting in
the mailing list archives for a couple of weeks, and it has not yet
been accepted or commented on.

-Alex
