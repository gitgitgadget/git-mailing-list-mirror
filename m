From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: CURLOPT_NOBODY
Date: Thu, 30 Apr 2015 16:57:28 -0300
Message-ID: <CACnwZYeVVKrTDM5rTaZz9sTjQ9tjWsk52D8WMu8kDM3vxEiVLg@mail.gmail.com>
References: <CACnwZYdCitEJ=pr=1+C_Wz5pKTbSYj4hD7mQHLC3gaDO8CqnrA@mail.gmail.com>
	<20150430035512.GC12361@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnuaU-0002mC-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbbD3T5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:57:30 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36496 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbD3T53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:57:29 -0400
Received: by oift201 with SMTP id t201so56613845oif.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4OCRPI07rRRUJiwgBHIT+REgSbb3ZoTBKBgfUgBooXg=;
        b=TB7StrYBJbpWvmBNBGi5KCwcK/dXlG0eNjkt5tIAH61/jtT8F0gz9hxWJLR+QwFKxD
         JdAovend39tcNxzfgR69i1m4zrNNGsyayjlFg6UVdzy7UYh/h+qEz/sCJN4N42CDnGb8
         4yC4qj0aVb3iFLJfZnuIc3RVYfWyxwqtguMcqYkt5z6w3ekh83QPY/ID/sZ0qGI71ERE
         NfQlU6BRlPxoQvuBuFvxW6AXyJAzX24Dy6JWwbGENaYiBgJcS5xBDF/J8f56BbbpYCqq
         C0zoEm7w7uRGur0S3910H0hAlc05aE+ar9VdzU1EzuZ7/ifHIi6eEbyFlp4CQqb0ZHEl
         zvKg==
X-Received: by 10.60.142.200 with SMTP id ry8mr1427326oeb.72.1430423849036;
 Thu, 30 Apr 2015 12:57:29 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Thu, 30 Apr 2015 12:57:28 -0700 (PDT)
In-Reply-To: <20150430035512.GC12361@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268102>

The same logic you apply to CURLOPT_FILE -> CURLOPT_WRITEDATA?

Bye!

-- 
Thiago Farina
