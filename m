From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Distribution size
Date: Sat, 26 Sep 2009 19:53:00 +0800
Message-ID: <be6fef0d0909260453x374b5ed4h21ff79a107fde28a@mail.gmail.com>
References: <1253962653-sup-1882@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 26 13:53:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrVq7-0006v3-72
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 13:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbZIZLw5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2009 07:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbZIZLw5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 07:52:57 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:54791 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbZIZLw4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 07:52:56 -0400
Received: by iwn10 with SMTP id 10so1945650iwn.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TwUYPltE4rIU/uWwadz6qq/dAtuVsaE0bpW9qBfKR3U=;
        b=C2gEfLB2/ZyW2ZPZjWKN82Bysd2/ixRs/9XoA4WM75edkOt2wuGNTompi64O2WVj25
         KfCdSZBiCOBjFLtzZpt8UWYi8mLgVL4+GbZHy0jNzsDjEuYoRJ2xk5ggiGA1bae0q64F
         Gh6Sa86RlXzegzIQTi1B7pYq+5HxkIPCdymGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wdkzsXprN72BwL0+U/T+8Wx7rQ9q0TtU/1wg5QCJS+S8/r0b/RXWEG6wCJAIuK2YyS
         ESFfdwEHUMKpfpyRAYv9ltuCsRVBupIK893QOm0gJ5B/1h1zeEsuPjSIL6cnejg1FMrA
         XFsmr4e0hZMQnu78SwniO1/0IdF+vXnYF5XXA=
Received: by 10.231.124.166 with SMTP id u38mr2474489ibr.17.1253965980387; 
	Sat, 26 Sep 2009 04:53:00 -0700 (PDT)
In-Reply-To: <1253962653-sup-1882@nixos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129151>

Hi,

On Sat, Sep 26, 2009 at 7:11 PM, Marc Weber <marco-oweber@gmx.de> wrote=
:
> git-1.6.4.4 i%du -hs .
> 115M =A0 =A0.

perhaps it's due to usage of hard links?

--=20
Cheers,
Ray Chuan
