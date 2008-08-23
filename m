From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: About git pretty
Date: Sat, 23 Aug 2008 01:38:31 +0100
Message-ID: <e1dab3980808221738m495dab8ep95880e6151614a92@mail.gmail.com>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
	 <7vd4k062k2.fsf@gitster.siamese.dyndns.org>
	 <e1dab3980808221704h3c713e64n41adc631d7a79601@mail.gmail.com>
	 <7v4p5c612y.fsf@gitster.siamese.dyndns.org>
	 <e1dab3980808221734l470134d3u62bd708e7baabe0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWhAG-00018k-8I
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYHWAid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYHWAic
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:38:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:60307 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYHWAic (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:38:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so927844wfd.4
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NvnaDn15g0OtcUaMP7OHa+fyjzSMdoJdBzimpS47yr8=;
        b=es9kF9tsqtZ+rxs4b5XfReVrqajGUutgcHAZPldnFhS0jtJKXWFd5KoKLb/6OzkJNV
         h8/r8Uo0pkwOIRfyzJsbxVNYuSa1//5r5NQdKDn/MtIpwEUGkVpVSXK9NlR9AjHWu6zC
         MguwK45ZH276ddWRaPV9t6bN+yk6wrucKI3Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vG8EmktsEiSO+G4ktUSQcyOVEaUnT5BBps60i5gRGnvd7IeGL0+ZUkWTTt/US1zt9E
         75VIoFK6qS+AeWlhRk6WxbhChEfANv/VaYeG4AxAkg3dGClNJ/DjK+Dhtjw55BI0yyd8
         tBBBBpMjZGwYDFIHQIVHcqIhW+jvYjadk4t/E=
Received: by 10.142.217.17 with SMTP id p17mr627481wfg.105.1219451911572;
        Fri, 22 Aug 2008 17:38:31 -0700 (PDT)
Received: by 10.142.136.18 with HTTP; Fri, 22 Aug 2008 17:38:31 -0700 (PDT)
In-Reply-To: <e1dab3980808221734l470134d3u62bd708e7baabe0d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93412>

On Sat, Aug 23, 2008 at 1:34 AM, David Tweed <david.tweed@gmail.com> wrote:
> Being honest, my only serious issue was with git reset. The about the
> first five times I knew the "operation" I wanted to perform by
> carefully checked the man-page because I wasn't sure whether --hard or
> --soft corresponded to the operation I wanted.

It's too late for me to make sense :-) . An ungarbled final paragraph:

Being honest, my only serious issue was with git reset. For about
first five times I knew the "operation" I wanted to perform but
carefully checked the man-page because I wasn't sure whether --hard or
--soft corresponded to the operation I wanted (and didn't want to take
any chances of picking the wrong one).


-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
