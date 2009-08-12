From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: How do gmail users try out patches from this list?
Date: Wed, 12 Aug 2009 20:43:18 +0700
Message-ID: <fcaeb9bf0908120643yf6f24a3h4bf14df42777aae0@mail.gmail.com>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
	 <20090811221408.GC12956@vidovic>
	 <200908111917.19267.wjl@icecavern.net>
	 <4A827BF3.8080208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Wesley J. Landaker" <wjl@icecavern.net>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, skillzero@gmail.com,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 15:43:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbE6z-00081Y-QZ
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 15:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbZHLNnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 09:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZHLNnT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 09:43:19 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:61386 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZHLNnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 09:43:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so14467and.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UE6RZzS3/Olee4gA+SkAZ6Lp0xyYKjmUZrz6TOBXtfw=;
        b=M8FvYIh8zxU8ZEMTj1VwGSmM4AZv8q9gIBFHiipfP7fV7/oFWagSIjxecEofUUWBwL
         3stR8uFplQ6kgRTQsa+kqekH9p7XWCGfAX9vPb6k0Vu+NE8k00EoWck4ScBhrIk3WofK
         ermw7GVNu6aAG9Ks1q2P8qrpITEU1wop2CFy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PdvI9mLoJcPkMne/xbGepB/5YSypa1JHgD3d8YVgdHdAeON4lzVExI3UjoFaZlkNaI
         Qbm4souXM8E2j/cbmO4nFXoXpsDR9wGuLI+y4HiLwvBBSQcKfMXCEuTVKu2GVRZV1Gz3
         aokmLNkE1MKCa/l4HFGE4IGMt39zh6+RKFCDc=
Received: by 10.101.113.16 with SMTP id q16mr126312anm.47.1250084598700; Wed, 
	12 Aug 2009 06:43:18 -0700 (PDT)
In-Reply-To: <4A827BF3.8080208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125698>

On 8/12/09, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>  I guess for them (webmail users) it would be better if we attached
>  patches, but we don't do that here. In any case, our list is mirrored on
>  gmane, and you can use the interface there. For example, you get the
>  first message in this thread using the gmane id or the message id like this:
>
>  http://article.gmane.org/gmane.comp.version-control.git/125591
>  http://mid.gmane.org/2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com
>
>  If you add /raw to those URLs you get the original message so that you
>  can happily wget/curl/browse and save away.

even better http://download.gmane.org/gmane.comp.version-control.git/N/M
[1] (where N and M is the gmane message ID range) gives you mbox
format of a series of consecutive messages.

[1] http://gmane.org/export.php
-- 
Duy
