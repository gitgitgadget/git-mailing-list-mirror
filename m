From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [Patch] Added http-protocol for git in the Documentation folder
Date: Sun, 3 May 2015 13:12:21 -0400
Message-ID: <CAPig+cSJWdrS-bBXcHE5ZmpZ3Aj8tKehXgFan6=4qxzrNKG8zA@mail.gmail.com>
References: <CAKB+oNsPzoBRUn6rD3Bb8soHEub3quT76MB25KyWfcEC1smdJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:13:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoxRv-0007W9-Q4
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbbECRMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 13:12:24 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37327 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbECRMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 13:12:22 -0400
Received: by igblo3 with SMTP id lo3so67553398igb.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kunWeBHfajeAmOhFchlh9bcUffYqm68VhmU4EGIODG8=;
        b=hFtBFWhCIfrMWmAELcH1cd2wp90FvUF4da+A6gVZz/Y4Zsc0YKz0j1XSedvaN/jgIa
         sAhZfvkGRNzPExbhre3H/j1qJSclmgK3x9Wxchjb5XoQcSkI3UZBNYGrIxtdveFUVsX5
         izrYCszihI4C4dWxK8E+EC57xjjte49XZA6qc4wFuUxIrsfxLnhsxb9qrQYXZsOiOD5J
         c3OOVxFmBvKN6ZwjAbY1q+ogv+B6DkXBwGMVpNLflVO9r75GxGmslA9l8U0itimtlNfA
         kBnt95Wt2Dg8knZK4j27HswDe24x1OPN9PFPbLWoVpjvfsUytOy9eS/P5c8dFiRuR19f
         e6Ow==
X-Received: by 10.107.3.163 with SMTP id e35mr22749559ioi.92.1430673141792;
 Sun, 03 May 2015 10:12:21 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 10:12:21 -0700 (PDT)
In-Reply-To: <CAKB+oNsPzoBRUn6rD3Bb8soHEub3quT76MB25KyWfcEC1smdJg@mail.gmail.com>
X-Google-Sender-Auth: 9sVHV75dkkQwnpcYjyGdboQrkVU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268272>

On Sun, May 3, 2015 at 12:18 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> This patch is to include the http-protocol in the documentations
> folder as stated by the left over projects here:
> http://git-blame.blogspot.de/p/leftover-bits.html.
> I got the documentation uploaded by Scott in his drop box some years ago.
> https://www.dropbox.com/s/pwawp8kmwgyc3w2/http-protocol.txt

This document was imported into the project by 4c6fffe (Document the
HTTP transport protocols, 2013-08-21) at
Documentation/technical/http-protocol.txt and has already seen several
changes since then.
