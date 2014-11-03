From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: clone part of a repo?
Date: Tue, 4 Nov 2014 06:13:32 +0700
Message-ID: <CACsJy8BtZefphZEd1iwPB8T1fGBnqjqRGGUxkncrDtSiE2DEfQ@mail.gmail.com>
References: <CACv9p5ofpzKof7ed_pTskQmsLVt0XL1NdAkYXUC8+NK7fVGisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: leam hall <leamhall@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 00:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlQp8-0003ME-0K
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 00:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbaKCXOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 18:14:06 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:49124 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaKCXOF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 18:14:05 -0500
Received: by mail-ig0-f172.google.com with SMTP id a13so5648590igq.17
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 15:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SWbqnO1IRerUMwcAB8RxoNY3K5xX+IrfjQ1MQPv9eZo=;
        b=lWH1ieJvChuyBAMv4hrxkQL79lJJzf2d/FaHn2EfBC2YNh/p7KQtTNSt10DCMwTJBa
         lYIRq82nu4SM5OqQGRE0iSXv/J7sIWMGHcQJ7zcUVKieqPMBICc8jogL3JL2agfdYQp2
         OwtTPmYUbzoSjlhUeOMHi8NnQab3hmdznhQyFx5LpWE5+nJQU9J9sOQz1hpctwH7E2Uy
         6XHcxHBJ2Xpf9p6IzxddbpIhneS/bqang1P16UBS7S219wJZBlj5URntJ0Fu38FPF3Mk
         ComABZ+hQAPREj8KU+xmrUWZy74512J+3W3gNMaa9COJNO2jQ2CT0JfbNm63/udszhSv
         hkYQ==
X-Received: by 10.42.114.18 with SMTP id e18mr44699552icq.42.1415056443662;
 Mon, 03 Nov 2014 15:14:03 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Mon, 3 Nov 2014 15:13:32 -0800 (PST)
In-Reply-To: <CACv9p5ofpzKof7ed_pTskQmsLVt0XL1NdAkYXUC8+NK7fVGisw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 4, 2014 at 2:44 AM, leam hall <leamhall@gmail.com> wrote:
> Is there a way to clone part of a repo? For example, if Joe has a repo
> of great code and all I'm interested in is one section, can I clone
> just that one section?

That's what I call 'narrow clone' and no it's not supported (work
started long ago and stalled)
-- 
Duy
