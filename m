From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #04; Wed, 14)
Date: Thu, 15 Nov 2012 02:22:29 +0100
Message-ID: <CAMP44s1-bMjr3_XUwkG2XSNzq_aUzHXrs0ZieHDCn+JBYOQMoQ@mail.gmail.com>
References: <7vhaorajrh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:22:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoAG-00041m-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851Ab2KOBWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:22:30 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39608 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab2KOBWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:22:30 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1169355oag.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NSqfqAAbwsWu+iRvJjTC7tPc2zBg4XDSmEIXva/2N80=;
        b=Z39UNom52H/OCu7Qt4Pv9i+px2Jtfa3ZGkMT3F7gqLLebxCSv2RPNqNCarKrsD23PN
         PGaTaippKUE4UFY2PrTUDGbE6ZsHaSkEfZtyXYnCuwY4pYXCvOpHAsJgFAZsWjt+SEMi
         /6MH+5VuHwk41HJfvIf6sBMipY6RoznD9dWdpucJxduFNSKaL5QsPY+dboVn8114+Qn8
         lWCpgX8s1SBr5fcoc6wShA6KkOr7C7JI22vhA19esBbKmKP2grm1Xb3/bwW+becL17uI
         jwrxnPjoCs0plu2LHJmcnYbt9XVwfWFNcGFH6x8vGafciDTpg3sIN4q3EzssF42oEew/
         uClw==
Received: by 10.182.38.101 with SMTP id f5mr22882721obk.80.1352942549636; Wed,
 14 Nov 2012 17:22:29 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Wed, 14 Nov 2012 17:22:29 -0800 (PST)
In-Reply-To: <7vhaorajrh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209779>

On Wed, Nov 14, 2012 at 11:42 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/completion-test-simplification (2012-10-29) 2 commits
>  - completion: simplify __gitcomp test helper
>  - completion: refactor __gitcomp related tests
>
>  Clean up completion tests.
>
>  There were some comments on the list.
>
>  Expecting a re-roll.

This was already re-rolled
http://article.gmane.org/gmane.comp.version-control.git/209382

-- 
Felipe Contreras
