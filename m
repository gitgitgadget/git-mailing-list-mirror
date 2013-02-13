From: Scott Chacon <schacon@gmail.com>
Subject: Re: Git-aware HTTP transport docs
Date: Tue, 12 Feb 2013 18:23:02 -0800
Message-ID: <CAP2yMaLz=vpOVgpxG0CwVwWD_sq+T9px3w0KXE7doUFhKqNZWQ@mail.gmail.com>
References: <20080826012643.GD26523@spearce.org> <511AED98.5070809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	git list <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 03:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5S0i-0005er-HL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 03:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab3BMCXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 21:23:25 -0500
Received: from mail-ia0-f178.google.com ([209.85.210.178]:49307 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209Ab3BMCXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 21:23:24 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so716812iab.37
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 18:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zPaQvUE1wC6PKvEabpQ1DQj8KidXHOH3hvCmPvsUY2k=;
        b=WedbWd14AO+M9lVk5inaN91Ob3IGf9eAnu5SfN8I/P95EmFxCeAPCG3e8VA9+RI0xc
         mUnpkZJhMVlMbg/LmSY2h8kkZk5Gi1u4nQZ2k+wiCo2jGcnvkLqVGkjcMFqfBTuzHUQh
         7GcZW0LyKaACOPUCJVf6SvoivfUiN8x7QIlHdbaSRsp1pl5mG9LlKU0pet7+uxWV82r1
         fdVN3rvpKZV2L8m+kjbpsjzXrZN0wS5ijWshsf6tQABNvqNRrEaNhdYgB4jnnNzd8uVC
         /PQQ3cNpBod9seYifbvZK+/DEdTpOn10P1tSiDYzl7mhwrbzl77XUhMiodLJwRWiiY91
         jYtw==
X-Received: by 10.43.7.7 with SMTP id om7mr27467442icb.25.1360722203851; Tue,
 12 Feb 2013 18:23:23 -0800 (PST)
Received: by 10.231.55.200 with HTTP; Tue, 12 Feb 2013 18:23:02 -0800 (PST)
In-Reply-To: <511AED98.5070809@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216235>

I don't believe it was ever merged into the Git docs.  I have a copy of it here:

https://www.dropbox.com/s/pwawp8kmwgyc3w2/http-protocol.txt

Scott

On Tue, Feb 12, 2013 at 5:34 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Hi Shawn,
>
> You wrote a really great protocol spec for the smart HTTP protocol back
> in the day.  It would be really great if it could be checked into the
> git repository (updated if need be).  Someone mentioned today trying to
> reverse-engineer the protocol because of a lack of specs, and I was a
> bit surprised to day the least.
>
>         -hpa
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
