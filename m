From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 14:42:33 -0400
Message-ID: <CACPiFCLw6CqteJfPjXE86deDuvAH-Bua8pKks=bDv1x6RtxxYA@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org> <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
 <7vipd5s161.fsf@alter.siamese.dyndns.org> <CACPiFCKxYdF8G33myfjOXU31cDWrfrtedve8m89tH_tfOCZ4ng@mail.gmail.com>
 <7vboixqf08.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jan Engelhardt <jengelh@inai.de>,
	Thomas Badie <thomas.badie@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svuvj-0007HQ-Ab
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 20:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab2G3Smz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 14:42:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52162 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab2G3Smy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 14:42:54 -0400
Received: by pbbrp8 with SMTP id rp8so10239921pbb.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FZdgZRCg4q3TK4x7z2tlXzTo8KY1SLq6AYkH1hQw6Bs=;
        b=tj5XfFDYmHqQB3TlmPkidePO6SsqD+OVuEGr174HWhxaPvXcHhtRLRhQcjPEZMOY9W
         KxEgcUdQ9L8CDJ9groeG3/o9/ID/pyNK7NHMFBFb7CUnHCAG9iY3SQK6mzzZ1lY5rPI0
         xEqxbfdog5W/ccBHkjZKHVxyv3YI6PMfoxNMR5ZZvxbRm+GQNMh4d3sBH/ykVSJ2OgBE
         Z7M2exRLRDa6rOlUFYGGeFqHMvfZyU/fR8dmPOQ8466X11X3EU0ZGoVhlK19MZ6hKtOu
         cu9GhpqLB0g9uhlO/Tzsb3QZd8sL0VIHSHu4CvIphB+zOGFSED/aa4GHAZFjTzt/0ptB
         ENQg==
Received: by 10.68.136.233 with SMTP id qd9mr37506450pbb.166.1343673773878;
 Mon, 30 Jul 2012 11:42:53 -0700 (PDT)
Received: by 10.66.249.232 with HTTP; Mon, 30 Jul 2012 11:42:33 -0700 (PDT)
In-Reply-To: <7vboixqf08.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202604>

On Mon, Jul 30, 2012 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The idea was that you do not have to give abbreviated SHA-1 to Git
> in the first place.

Ah, sorry, I didn't get _that_ point. I thought you were trying to
demo a way to get a sha1.

> What doesn't work?  My copy of v1.7.10.1 seems to grok the above
> just fine.

Gaah, it barfed at first, works now. My apologies. I may have
mishandled the copy to the terminal -- dropped or corrupted the
single-quotes.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
