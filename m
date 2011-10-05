From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 5 Oct 2011 13:43:19 -0400
Message-ID: <CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
References: <4E8C6F2F.1070306@6wind.com>
	<7v8voz8hgq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBVV6-0002lz-CG
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935166Ab1JERnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 13:43:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54277 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934662Ab1JERnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 13:43:19 -0400
Received: by yxl31 with SMTP id 31so1811528yxl.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a5JffVNpexfNVUiFvd5IaQQljEZhCp6f8RahDistrGg=;
        b=BSWJzchbhdM4Wp3lLoL/LJSpq3ZGOfghIO4BrvlsOurUB9BOrQFHSz6v8sA/Y2DPcM
         oVEhhb6e7XjkClmIX8KYO+lbuJxeh3Ot6x/H6icZ4L0Jv0ZtQhyhmiRKxjB/wXMZFMWT
         EPCvgNztj447djsxlxrReTXjL4BmmhscZlRZo=
Received: by 10.147.154.12 with SMTP id g12mr2301615yao.36.1317836599254; Wed,
 05 Oct 2011 10:43:19 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 10:43:19 -0700 (PDT)
In-Reply-To: <7v8voz8hgq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182869>

On Wed, Oct 5, 2011 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pinging Jay who may have know a thing or two from the history leading to
> 37f7a85 (Teach commit about CHERRY_PICK_HEAD, 2011-02-19).

Yep, I replied to Nicolas' other message.

j.
