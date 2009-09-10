From: Eric Schaefer <eric.schaefer@ericschaefer.org>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 20:18:14 +0200
Message-ID: <34f8975d0909101118x7c95be1ehda085bea1611b70c@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <m3fxavvl5k.fsf@localhost.localdomain>
	 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
	 <200909101116.55098.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 20:18:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MloE0-0003ZM-83
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbZIJSSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 14:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbZIJSSS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:18:18 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:38829 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbZIJSSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:18:17 -0400
Received: by ewy2 with SMTP id 2so385404ewy.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type;
        bh=2HQwDwQLsZ3MRy760NSf2174KTjoBhdw1m0NvyoDseU=;
        b=nrLx8Wt6MnbI6htEG6I/dyTv5LrF2cELkonhJiw8lmAkYMljtttR8ZYFYay+etVVGd
         6LMuxDmMkQdmwFJEpwsJpiLBiP5L7KEorkWXxXhBXqgixNQLjRtz97/IHfynN3wWKTF2
         IAXOBhywE10af0d3h/GuzC1pG1wmoDJFsIufU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=rrs52gDpQgpdNjSgTQbFMQ9QMPEyccbyfVFMUSLiNJgTDPZ4p6ar9VbdQByKYcegNG
         BUBJ5Y1HS6HUAFK28OVup8APzlzwVAUXUIgL6FvNH9VqkJ5d6DAAO205ioRpM1eZJJ57
         9cp7mPcePvTiJZ/iw76lWhER9tDqCzP9Yk8CI=
Received: by 10.216.55.195 with SMTP id k45mr614548wec.70.1252606694846; Thu, 
	10 Sep 2009 11:18:14 -0700 (PDT)
In-Reply-To: <200909101116.55098.jnareb@gmail.com>
X-Google-Sender-Auth: 12fbaaf7990ea574
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128129>

2009/9/10 Jakub Narebski <jnareb@gmail.com>:
> This is a good way to separate important from unimportant bug reports
> and feature requests ;-)

"Unimportant bug reports"? Interesting concept... ;-)

BTW: A bug tracker has the advantage that bugs don't fall on the
floor. They can be postponed for later fixing but you will not forget
them.
But you are right about feature request. You would either have to have
a rigorous policy of dropping bogus or unwanted (unimportant) requests
or you go with the mailing list approach to keep the pile from
stinking. ;-)

Eric
