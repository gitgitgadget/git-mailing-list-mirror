From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] doc: remote author/documentation sections from more pages
Date: Sun, 26 Jan 2014 19:15:30 -0500
Message-ID: <CAPig+cQ3w-VrjbgwgSMCRovR+P27f8GignyYG+bKic4RZEc5Gw@mail.gmail.com>
References: <1390779829-24168-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 27 01:16:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7Zrx-0002Ur-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 01:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbaA0AP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 19:15:56 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:52447 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaA0APc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 19:15:32 -0500
Received: by mail-la0-f45.google.com with SMTP id b8so3945742lan.4
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 16:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pItcmafC/3nMfPti14O7CxL3lb8JuJN10y1ZmybYMN4=;
        b=SB+rYdQy6UwMuEqsKafBvFz3v6qRbyw6r/pa1jNVFfoHqr2Jv5VaNr6AFVn05AyZJz
         Fy3jtIadi5teb9suHP0SqNaTh8WOOH4kCAxswzpcMN1QKPb1vbxqIna6EedXPFER9Ijp
         ykhi8D8tFurmwUsJJZABfFiOh05R5/HMfPno9UB6t7CbmYTEblCal/duuJ3Axfixlm5D
         tug0xjtmeCWKlPFK0F8riOSYM4M1W2SX5REQzGnXcY9TVZBDX0EomCEZJ8dFVOqJ/OdJ
         P7lzlKn1/J6RCXvFB2R6/WziU2GmOldAr4tVmpJI4UqbOSqZ8c38bLkGYVcY0z4Uc+TS
         Gn6A==
X-Received: by 10.152.43.47 with SMTP id t15mr336909lal.38.1390781730775; Sun,
 26 Jan 2014 16:15:30 -0800 (PST)
Received: by 10.114.181.228 with HTTP; Sun, 26 Jan 2014 16:15:30 -0800 (PST)
In-Reply-To: <1390779829-24168-1-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: AlAL1KxNTJadeG1VM9iuN0O-tcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241121>

On Sun, Jan 26, 2014 at 6:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Subject: [PATCH] doc: remote author/documentation sections from more pages

s/remote/remove/

> We decided at 48bb914e (doc: drop author/documentation sections from
> most pages, 2011-03-11) to remove "author" and "documentation"
> sections from our documentation.  Remove a few stragglers.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
