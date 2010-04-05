From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Mon, 5 Apr 2010 19:35:42 +0530
Message-ID: <l2pf3271551004050705o20379311j9862bd9ab46cbb11@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 16:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NymwO-0002lP-A7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 16:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab0DEOGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 10:06:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55854 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0DEOGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 10:06:04 -0400
Received: by gwb19 with SMTP id 19so1201284gwb.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=tpV1TUvkD3LCbRdb1DrCgbl6SxZN5PuTNZU5bF8xzNQ=;
        b=if914tI3DzQukKStJg5W6Wkx6/METuognZ+WFJU/aTcDho9meXTS/CY8PGDu0WSBdo
         Vuw/CLndGBvqo0nUHRJKmg/wRPoXjbSecy+Kx5p1Nzi03B7uj4G3a+IuojIckqtFWtPT
         eIEZ1gMVwydNKT35qHRrpJeYAUoLzD+mwrFCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=m6gmm+HqDiHK5ziBzO9hctLN4gOFDcztKGLlSvXMdUB9nLF0roiUcRqaHcTb78os7N
         sHLmlHB6/OC8xAqmeSk/vhcDe7ew88hHdC8VnWyXnEDMgPTE+TgZkXeZUlgC09GxOZhY
         HRQ/piSOGJ3uatJJGHFw0rHWite9wFUKweEPE=
Received: by 10.90.69.14 with HTTP; Mon, 5 Apr 2010 07:05:42 -0700 (PDT)
In-Reply-To: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
Received: by 10.91.179.13 with SMTP id g13mr1476271agp.8.1270476362190; Mon, 
	05 Apr 2010 07:06:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143983>

Hi,

On Sun, Mar 28, 2010 at 11:33 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Rewrite the description section to describe what exactly remote
> helpers are and the need for them. Also mention the curl family of
> remote helpers as an example.

In accordance with Junio's 4th April "What's Cooking" report, could
some remote helper experts kindly Ack this patch?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Thanks!
-- Ram
