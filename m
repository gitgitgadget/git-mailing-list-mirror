From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 0/8] gitweb: gravatar support
Date: Thu, 25 Jun 2009 20:46:01 +0200
Message-ID: <cb7bb73a0906251146s785fac1by6847e1d0350f195b@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906251455.32953.jnareb@gmail.com>
	 <cb7bb73a0906250615i2ed880eci2d3716aa1ca43e4d@mail.gmail.com>
	 <7v8wjggs2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJtxd-0002zK-Tj
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbZFYSqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 14:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbZFYSqA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:46:00 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:43467 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbZFYSp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 14:45:59 -0400
Received: by bwz9 with SMTP id 9so1603111bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+ZcYuT3mpdRh+odcZJ1CMXYeWcA4ysSCzct9j7hGihQ=;
        b=KaUsDpix0SrhLkweWYljqnd/3N6YlitAborpdpn2FUPQV38Xiqm4boKNp0NHVD5p/H
         9LLqU4uA1JdCzdTYmqkf1bqWSbL9uXv5K4liUmrgITuWAkWD4ro8AOnqq2aAGLGRuocy
         S2DYnFR/x/XwghWtS4zNg9r1FABl9mFRhiHqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WfBCjOdkZHBaFuGfY8TkcrxxNnC2X0q8HL0qutjgw8mOzGpPiti6/Ea9o7fVJ3TA+g
         D40zBIhOnjyMJ0SE8vIVZEQRJJilKhVSim8c55kPwrbbqxCYfL7uAGC0VhFRpKxsifOi
         GncuaDXPFAGpiGNprdGqq3p77aIw9o8oACA54=
Received: by 10.204.58.79 with SMTP id f15mr2700740bkh.202.1245955561173; Thu, 
	25 Jun 2009 11:46:01 -0700 (PDT)
In-Reply-To: <7v8wjggs2c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122232>

On Thu, Jun 25, 2009 at 7:07 PM, Junio C Hamano<gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> I was thinking about some form of fallback like that too, but I
>> haven't the slightest idea how picons work, so I'm afraid I'll leave
>> that enhancement to some later time.
>
> Yeah, let's not go overboard with the initial series.

Well, I'll confess that I've been on a coding frenzy all day, so
expect a new release with preliminary picon support as soon as the
review for the last patchset is done 8-D

-- 
Giuseppe "Oblomov" Bilotta
