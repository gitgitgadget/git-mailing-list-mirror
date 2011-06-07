From: Albretch Mueller <lbrtchx@gmail.com>
Subject: Re: diff'ing files ...
Date: Tue, 7 Jun 2011 22:12:35 +0000
Message-ID: <BANLkTinwSembzVk4gSYSvsRdHhDfqizkyg@mail.gmail.com>
References: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
	<20110606224356.GC13697@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:12:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU4Vu-0005NR-5L
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 00:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab1FGWMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 18:12:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57647 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab1FGWMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 18:12:36 -0400
Received: by ewy4 with SMTP id 4so1898997ewy.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oshYAbuqASzOMYLoX/M8+qpd2qCWAhYPptbhu7HtW1s=;
        b=Bx7T19Yru/6Z8AnbIhb3t6P4GNfJtbLUHdad6FpoI6WSIm0cqXd6frLl8fRFzwKrGN
         jN7U7e6m5lGg4MrsL1dsQw5yuVcr7CTqBO+gNnY4u2xxihTCCwWlQXwFexWc1H8LDwcQ
         4o/aVKlKQIz+wnd+JiR0tGVoZc6jr/vxQxOoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kP05NMYGYTtfb/N18kR5DiZpH/25T5mglXL4DxDv6ZRh8oqxyuy9WtdQ6r+0FQyqzw
         gySHF+e2Tw6/2gh0HkwEoLu9hu2VXDRhw31LB/kcAdagvK4Fuy2Dddi3a5Gveh0pC/Vm
         G0crveeSpIxHnxv1AAEY1QwC6j/WwIPw1OCx0=
Received: by 10.14.16.27 with SMTP id g27mr2652899eeg.5.1307484755545; Tue, 07
 Jun 2011 15:12:35 -0700 (PDT)
Received: by 10.14.119.134 with HTTP; Tue, 7 Jun 2011 15:12:35 -0700 (PDT)
In-Reply-To: <20110606224356.GC13697@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175272>

> ... binary diffs, though I don't know offhand the details of the algorithm.
~
 this is the part that I need ;-)
~
 Reading the source code without knowing the basic underlying
ideas/algorithm (just an outline if possible) won't help much
~
 Thank you
 lbrtchx
