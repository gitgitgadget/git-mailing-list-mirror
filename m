From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Bump core.deltaBaseCacheLimit to 96m
Date: Mon, 5 May 2014 17:27:49 +0700
Message-ID: <CACsJy8D3xXM3ht3JeoowiFQfoL28WDxyijRhyRKGDn4rfn4aSw@mail.gmail.com>
References: <1399223637-29964-1-git-send-email-dak@gnu.org> <CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:49:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhxL-0005Yp-A7
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbaEEK2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 06:28:21 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36234 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbaEEK2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 06:28:20 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so736959qcq.1
        for <git@vger.kernel.org>; Mon, 05 May 2014 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XMlT3J9sDv75arzV5Y1LVQ7rbAtfH8AjHE/AaQVSXCo=;
        b=wPz2VSG8LRzJLaAAdG6Y8g8T3PMM6mJThH80GJiVBHWPvwBvi+CMy2PiKxWRmq+PwD
         zMRiqi68QUdItao7HIycsKKzOW99jyeelPkKGhLYXsY3SUs7P4yALBudQwbSKMiPQOWA
         p87c6dC8LpBjiBaD8F05/zWQe1KakjjejJb18jdPlfauldFmhKciNZ5757r4rUPCywTV
         NF5YO9v+2OkRv8UKgBVJYKTVdMlQEjKnWt+2LOqigbqViDC1z0Ai965j3JO8TXFCTG1I
         fThmLXW9rTNwIejCBpS3tofYwKuyPdf11XAw5kaeI1q9P6jvwSEn7XGIAqL/tU7uGbhf
         MoQA==
X-Received: by 10.224.36.129 with SMTP id t1mr39571063qad.88.1399285699515;
 Mon, 05 May 2014 03:28:19 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 5 May 2014 03:27:49 -0700 (PDT)
In-Reply-To: <CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248152>

On Mon, May 5, 2014 at 5:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> part. Would it make more sense to advise git devs to set this per repo

s/advise git devs/advise emacs devs/
-- 
Duy
