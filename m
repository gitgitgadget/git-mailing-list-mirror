From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [PATCH] configure.ac: Add missing comma to CC_LD_DYNPATH
Date: Tue, 9 Oct 2012 18:40:29 +0200
Message-ID: <CAA787rmpTe1L4TY41X9Szt8FS9T7bYRA2sgb=K_st4Ck2N9M1Q@mail.gmail.com>
References: <1349800026-10717-1-git-send-email-sunny@sunbase.org>
	<1349800572-2963-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stefano.lattarini@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 18:40:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLcrK-0004AA-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 18:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2JIQka convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 12:40:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42758 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab2JIQk3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2012 12:40:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5387121pbb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z+vDjLLl3LnMT0Z2pJqEBoe6tMr5/xo+P+s9NPYGPrQ=;
        b=XMiKSebd3NC7v7nHRhQmOqVGM6RbYFxPzzbCLS0ZQPptE1HdUqO8m0KpytX7+V8hJP
         Sr3PufCcN2RtzHCklJG4WQpZn5vRaX3FAjsMAIjzcPiu1vim4t/lAh3nL+IjoyOApItV
         zF5mTwiIMdJdrSfQMaSxUC84WCU/BOpcuB507DemQi9FqHqboIE0DYF17zgmEG6LOM4O
         Rsze3zyamkfTIW+ZIUn3vOlpCgXNwWnN2d9c/NSyIGZYG4aPc13MDkEFZ0cvb9PNIMQQ
         Ha4IuZ3rjveBkAmt6oi8poobxrILOVKYalEGUTMLsvmEIVhVDLinkHVe2+kMXKLiCjQg
         4vSQ==
Received: by 10.66.83.201 with SMTP id s9mr44077360pay.74.1349800829135; Tue,
 09 Oct 2012 09:40:29 -0700 (PDT)
Received: by 10.68.222.7 with HTTP; Tue, 9 Oct 2012 09:40:29 -0700 (PDT)
In-Reply-To: <1349800572-2963-1-git-send-email-sunny@sunbase.org>
X-Google-Sender-Auth: x_PLpixADad_s3GLSyHfd0e48BU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207326>

Please discard the first patch, I reckon line 423 also should be change=
d.

Sorry about the noise,
=C3=98yvind
