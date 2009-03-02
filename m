From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Problem in pushing git
Date: Mon, 2 Mar 2009 08:51:44 +0100
Message-ID: <fabb9a1e0903012351r9e881f7w64601ec1b1fad9e6@mail.gmail.com>
References: <49AB8B4F.90006@providencesl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lahiru Perera <lahiru@providencesl.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 08:53:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le2xk-0000wG-OL
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 08:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759AbZCBHvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 02:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757821AbZCBHvu
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 02:51:50 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:42602 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663AbZCBHvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 02:51:48 -0500
Received: by fxm24 with SMTP id 24so1845159fxm.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bQSKYMtGJSNHhbbO+Tfz4w1Aep+63Ipj3ByVMeBsdd4=;
        b=iASUzTjzwz7RBnmiaPHCae+FnPA05uzSFOxJB/7w6Qy4N/Nmnejc+k0YLIBANqJASj
         BvSdDNjISCtYCp50JrC6gVZrtNDQ/9wLQfForiM9sBQG4LDKmP5RyiaiW/fuxXWLjqeA
         cLXjK1OkTNPhw2vbuHiTuQs+EdZ5+Z4JUfu+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T0hHi6dgTRqtX3dJiKXTeKoQrhfKbuqTjQJv6FaYw6zbH6JQsW5blx5eDV/IEzMopp
         2gXS2zmPED1UUCw8VPE+9yqzIgk0kiV3EjjJtxgremln5G5JDn8j/8WxZLjGTHG3HcBl
         5Mf8zc0GeGpKi52wNwSzuZPTrLKZit9QdNHfI=
Received: by 10.103.250.1 with SMTP id c1mr2787634mus.64.1235980304961; Sun, 
	01 Mar 2009 23:51:44 -0800 (PST)
In-Reply-To: <49AB8B4F.90006@providencesl.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111912>

Heya,

On Mon, Mar 2, 2009 at 08:31, Lahiru Perera <lahiru@providencesl.com> wrote:
> Im finding a solution from last few month

I'm glad to hear that you've been trying to find the solution
yourself, but why did you not look at the faq [0]? The exact same
question you asked has been answered there (see [0]).

[0] http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

-- 
Cheers,

Sverre Rabbelier
