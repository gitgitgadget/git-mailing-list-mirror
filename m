From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git Extensions video tutorials
Date: Thu, 22 Jan 2009 22:00:09 +0100
Message-ID: <bd6139dc0901221300j3ca50f4chfef836f4ec822cab@mail.gmail.com>
References: <1232655984838-2199944.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 22:01:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ6gE-0002Yn-Si
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 22:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbZAVVAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 16:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbZAVVAM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 16:00:12 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:28609 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbZAVVAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 16:00:10 -0500
Received: by rn-out-0910.google.com with SMTP id k40so839493rnd.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=IM9hb5x49tQJF/oJbgqa6wFxCuTxxrH8aOURIlnTWcE=;
        b=BfO7SdlQngzNhwU5cLPxIJF+BEYgdtDh4kg0N3Jln7YMM/xAco7YwSuAIL/YDGu9wa
         Qrs8NYyZNdG/erfEjgVGUQ+Bg0bbDUU8QIypxb1B1KMlUZ3ciPMpZfK3ycHnwxQS/KdW
         /gf5iLwIe03txDCHrcbe57d53BlcGH3rWUhRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=qpuYlaodQQZXqnaqt0NAdp0yCslSGi5OQ5eXm5L+MksvPy0sdhA0MoZD2iHkjU93Va
         Axdai0dANl+02CUxgErX+oHlA71MVsiTpHMZ7FTsPHq52GOstQMoCkgaS+5D3O5ipd84
         rvishI4rLAeNVZ7S4ONnc9+eNoy0ugA5KOzbc=
Received: by 10.150.12.5 with SMTP id 5mr4421332ybl.200.1232658009058; Thu, 22 
	Jan 2009 13:00:09 -0800 (PST)
In-Reply-To: <1232655984838-2199944.post@n2.nabble.com>
X-Google-Sender-Auth: 2c48c2b5144f86aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106785>

Heya,

On Thu, Jan 22, 2009 at 21:26, Henk <henk_westhuis@hotmail.com> wrote:
> I uploaded some videos to YouTube that show how to perform some basic Git
> actions using Git Extensions. All video's are captured from screen without
> any editing, so I hope they are any good. I tried to zoom in as much as
> possible to compensate for the low quality on YouTube.

Looks nice, seems like a git client that even a designer might be able
to use. The VS integration is nice as well (for those that use it).
It seems though, that you follow the svn paradigm "do not ever allow
the user to cancel what they're doing" even more rigoriously by simply
not providing a "cancel" button in the first place (as opposed to
svn's cancel button that takes about as long to actually do something
as it would have taken for the command to finish).

-- 
Cheers,

Sverre Rabbelier
