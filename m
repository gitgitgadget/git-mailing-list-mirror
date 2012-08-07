From: Drew Northup <n1xim.email@gmail.com>
Subject: Android Replies to Git List getting rejected
Date: Tue, 7 Aug 2012 15:24:58 -0400
Message-ID: <CAM9Z-nmEDTEN0Em-nY+y5g0kRMsNuy-pn8Lzr_mWSU7engj6JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 21:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SypOv-0002mv-HL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 21:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab2HGTZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 15:25:00 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47790 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab2HGTZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 15:25:00 -0400
Received: by bkwj10 with SMTP id j10so1572550bkw.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=GuRE96gTFmMHD9TtF+CIfcDOad6tgj0kzTWN1l4gdNo=;
        b=BWuNUiaNZM45WWQ/QKGYPWaNiisyShOy3EUy1CGLagjD5vQQxodiWKzzvW5dMaifF8
         +h8Jw6xP3p6CQOvE4fQfKSMkwutcJ/q7nZ8KCph0iyHbQRCBw9ttP/zVJat1aBU/Cbu6
         hNIXIW0+HObFTmGoMSTJWctXCCl3z3eukN0/1Ua5cY6PUiVl3HHf0H1xzhE8u4nf/asM
         d3nu0Nvmo6MTaNcKDE/ocguvqqjkYEy/yOa4sZYWW60rIYrzPZFAXtVz9hRbZSxBpZKY
         hQtaETgsN/UHj/dkoIWgbCiJtnD9/CwpD7dm0p/RrZDNcEiy32jLffLXA54GZA8FkkeZ
         LdMw==
Received: by 10.204.128.202 with SMTP id l10mr6164197bks.127.1344367498674;
 Tue, 07 Aug 2012 12:24:58 -0700 (PDT)
Received: by 10.204.27.24 with HTTP; Tue, 7 Aug 2012 12:24:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203039>

I am not 100% sure of the root cause of this, but I have gotten the
following error message back from vger via GMail at least twice now:

"Delivery to the following recipient failed permanently:

      git@vger.kernel.org

 Technical details of permanent failure:
 Google tried to deliver your message, but it was rejected by the
recipient domain. We recommend contacting the other email provider for
further information about the cause of this error. The error that the
other server returned was: 550 550 5.7.1 Content-Policy reject msg:
The message contains HTML subpart, therefore we consider it SPAM or
Outlook Virus.  TEXT/PLAIN is accepted.! BF:<H 0.0255687>;
S1755748Ab2HGTHS (state 17)."

I was replying to 20120806223113.GA16298@sigill.intra.peff.net
(Subject: Re: [PATCH] Avoid crippled getpass function on Solaris).
Hopefully all of the direct replies went through, but the list denied
it. Some other replies have worked just fine.

Before the usual raft of "you configured your mail client incorrectly"
I would like to note that such things are not configurable in the
Android GMail App. If this is an app issue I'll (attempt to) take it
up with them (and expect zero results). (I am writing this from the
webmail interface in the hopes that it goes through.)

Am I the ONLY ONE seeing this?

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
