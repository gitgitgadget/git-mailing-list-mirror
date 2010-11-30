From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Match lightweight tags too in bash prompt
Date: Tue, 30 Nov 2010 10:04:51 -0800
Message-ID: <AANLkTi=0+s164XkWHho1++hvnTCAFg5=GGfMbHF4ugTE@mail.gmail.com>
References: <AANLkTikeH=MODho_GsZP5VPQmt2NOoHyfw2pbt4yqGkt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 19:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNUZu-0005v0-1M
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 19:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab0K3SFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 13:05:14 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58625 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0K3SFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 13:05:12 -0500
Received: by iwn10 with SMTP id 10so35243iwn.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 10:05:11 -0800 (PST)
Received: by 10.231.35.202 with SMTP id q10mr7685693ibd.88.1291140311548; Tue,
 30 Nov 2010 10:05:11 -0800 (PST)
Received: by 10.231.154.5 with HTTP; Tue, 30 Nov 2010 10:04:51 -0800 (PST)
In-Reply-To: <AANLkTikeH=MODho_GsZP5VPQmt2NOoHyfw2pbt4yqGkt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162486>

On Fri, Nov 19, 2010 at 7:43 AM, knittl <knittl89@googlemail.com> wrote:
> From 1fea30e0167681917b4f40a3cb2cde9a90706011 Mon Sep 17 00:00:00 2001
> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> Date: Fri, 19 Nov 2010 16:40:02 +0100
> Subject: [PATCH] Match lightweight tags too in bash prompt
>
> provide `--tags` to git describe

Missing signed-off-by-line.

> ---
>
> bash prompt would display a commit's sha1, when checking out a lightweight tag.
> provide --tags to git describe in the completion script, so it will
> display the name
> of the tag (as it already does for annotated tags)

This information is useful justification for the change.  It should
therefore appear in the commit message, above the --- line.

-- 
Shawn.
