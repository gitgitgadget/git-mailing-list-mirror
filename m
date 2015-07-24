From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Documentation/git-tools: drop references to defunct tools
Date: Fri, 24 Jul 2015 11:03:54 -0700
Message-ID: <xmqqmvylmnzp.fsf@gitster.dls.corp.google.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
	<1437710457-38592-7-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:04:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIhKF-0003KK-MD
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 20:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbbGXSD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 14:03:59 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36154 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbbGXSD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 14:03:58 -0400
Received: by pdjr16 with SMTP id r16so17139351pdj.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 11:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=M9mrHUv1K6+t2nXRgLuXWtUq6qTyJSC5G3fm+ue+xgc=;
        b=t133EjcfEJgIxlLP2/eVdcGgmqKAvTqXOMS6zw+n8NHH47Ixe1jTaKL8a+nd6kdF2s
         +HIq6o0vAuExBxuahcLJsu4BzbY+3jM9QvE3AdUce8kF34i6ZhcJGCNGCSiPaSiFCBVR
         LBCh6n4ODX4w482VLztC22aj9RjON6N3G1OXWm1wm+K5odSON47+dDfExawczPz8Zgcc
         KfTOmLqHJYEqyeCDUX4Pu83K3Rpt9ekAjVMy3yaX8Fmjel6wJgKDTSXNe7gdMDQyxDpl
         3grPUmrwYwGQ6eqNvLE8YS2S3ed0dfZd0TAtw7Zy6f9k568j1VU4VrVR0IoYsTZc2TVv
         oCcA==
X-Received: by 10.66.147.227 with SMTP id tn3mr33814122pab.130.1437761037307;
        Fri, 24 Jul 2015 11:03:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id h12sm15725940pdk.77.2015.07.24.11.03.55
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 11:03:56 -0700 (PDT)
In-Reply-To: <1437710457-38592-7-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 24 Jul 2015 00:00:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274575>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Cogito -- unmaintained since late 2006[1]
> pg -- URL dead; web searches reveal no information
> quilt2git -- URL dead; web searches reveal no information
> (h)gct -- URL dead; no repository activity since 2007[2]
>
> [1]: http://git.or.cz/cogito/
> [2]: http://repo.or.cz/w/hgct.git
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> Perhaps it would be better to drop all items, and retain only the link
> to the Git wiki?

Hmmm, that's a very tempting thought.
