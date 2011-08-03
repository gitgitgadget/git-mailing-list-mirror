From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git-am: ignore leading whitespace before patch
Date: Wed, 3 Aug 2011 20:28:19 +0800
Message-ID: <CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 14:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoaYn-0004CW-0c
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 14:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab1HCM2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 08:28:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45948 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab1HCM2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 08:28:21 -0400
Received: by fxh19 with SMTP id 19so619905fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CQIhzwhP874YanqKlqkV9AIL4xHNbBD8iryuOkQw1oU=;
        b=iu8w+ZZZwbd3t+4gg4b8j98GgrqpPZOT9fndsobOz3U7DoEV3xPPavWgWED4K0c/oc
         uZT4hqM2tHWezpJTrLsqG4xb7EgIG9qc049M0c4J+QVkU5K1gwtFPEWwwI1e3hTof4wy
         SdjJSNnhdp9d5IcZQXs6cBmiIrtYh87d2NoS0=
Received: by 10.223.1.135 with SMTP id 7mr3246890faf.46.1312374499741; Wed, 03
 Aug 2011 05:28:19 -0700 (PDT)
Received: by 10.223.87.66 with HTTP; Wed, 3 Aug 2011 05:28:19 -0700 (PDT)
In-Reply-To: <1312323646-93427-1-git-send-email-davidbarr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178564>

On Wed, Aug 3, 2011 at 6:20 AM, David Barr <davidbarr@google.com> wrote:
> Some web-based email clients prepend whitespace to raw message
> transcripts to workaround content-sniffing in some browsers.
> Adjust the patch format detection logic to ignore leading
> whitespace.
>
> Signed-off-by: David Barr <davidbarr@google.com>

Finally, patches from GMail that play nice with git-am!

  Acked-by: Tay Ray Chuan <rctay89@gmail.com>

-- 
Cheers,
Ray Chuan
