From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/3]
Date: Thu, 14 May 2015 12:16:17 -0700
Message-ID: <xmqqvbfvj7ge.fsf@gitster.dls.corp.google.com>
References: <1431541434-21884-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 14 21:16:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsycK-0006dd-Rb
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbbENTQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:16:20 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36651 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933403AbbENTQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:16:19 -0400
Received: by igbpi8 with SMTP id pi8so175809410igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ydufBamZHlIgOrL+R0jil7w9GZK9UZmTufkVnrK8En4=;
        b=KhpkOjtKBUvULmppDCzRIWaiIRGJXVmM4Y2/YGzsifmbsHmiy901h6iKH5qNiFGT/X
         Yq0PB/uJKi9//VPo1yXjQxTuibywc4SBLoh/a8TdKvjxvxhlKX1KMWsw/O9jPamP8Dmj
         OAYl6+NlYTLSykcSGz7MPANk1A59cxJxpQNXW3cENqjyTSTOzYe67VV+7bLhYQrY+GxJ
         /xHhSNjocrTMqJydGCm1T7GQ7NYAMaFXxC37zs23FzRiOdV8Ka+Ix6yV74q6+vr2ejNn
         X8KtLr2lqcgtCQgyLDmMERI40s+RkpK2PTIDJR8M4wB01jjitTowG5t+zjXGvZWx9xui
         FkLA==
X-Received: by 10.107.167.73 with SMTP id q70mr7374357ioe.82.1431630978927;
        Thu, 14 May 2015 12:16:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id l6sm4275209igx.10.2015.05.14.12.16.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 12:16:18 -0700 (PDT)
In-Reply-To: <1431541434-21884-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Wed, 13 May 2015 14:23:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269070>

David Turner <dturner@twopensource.com> writes:

> Oops, forgot to ammend commit before patch v8.  This patch *really*
> includes the switch and type casting fixes.

Thanks. Will replace.
