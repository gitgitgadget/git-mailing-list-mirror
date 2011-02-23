From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Wed, 23 Feb 2011 14:45:58 +0100
Message-ID: <AANLkTinEFRn2AqT7c56MgZ94nk4JL-tRnWgW8iQQHf4f@mail.gmail.com>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
 <20110222080305.GA11177@sigill.intra.peff.net> <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
 <20110222081458.GA11825@sigill.intra.peff.net> <m3wrks756a.fsf@localhost.localdomain>
 <20110222152723.GA23353@sigill.intra.peff.net> <AANLkTinTj7BehKYc15jbQzMq+q=2CfLvzTkGSJ-Ps-FH@mail.gmail.com>
 <7v7hcrewyz.fsf@alter.siamese.dyndns.org> <AANLkTiki9W_mJKLON+punKJLDWx5rmQdZ3bS16zadYFj@mail.gmail.com>
 <4D6500C5.7020803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 14:46:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsF2u-0003cu-3Y
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 14:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab1BWNqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 08:46:19 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34502 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab1BWNqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 08:46:19 -0500
Received: by qwd7 with SMTP id 7so3729561qwd.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 05:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fr20yZHsTt//jGX5lKCaaoBqcwfFYExW5Z7tmedTN/Q=;
        b=ZCCk8BPGzPjvsXj95Z4i+/DnX29Q1CkcSFWIl8M/AyynH1BfejpGaQNGcC0qtO8OVA
         U/bZ/0cIeRBM+a1sMOQNWaME6pMLMMXIQStxKLG2BnjzJv3QoQvyYbpLaqTGEdzfXKlZ
         hrTFBOBnwYt8GqmTGVklMaWletl/SlLeU/8fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xna1Q8Um9TBPfzNCbQocL6/r6BnHmrX30eGzXLZtvRjkifH4ictYeJtjjAgpo8nimq
         +tfeJdPh4alZZQxppBsCrQ0d8UBumGZGaDFjHEKkf8U6+FDyBeqzZvVjHGQPet7GLnrz
         GbmgeMb7wFmhF89kLXnw8SF6/o2BKif99Jj9I=
Received: by 10.229.81.6 with SMTP id v6mr3084478qck.223.1298468778101; Wed,
 23 Feb 2011 05:46:18 -0800 (PST)
Received: by 10.229.50.6 with HTTP; Wed, 23 Feb 2011 05:45:58 -0800 (PST)
In-Reply-To: <4D6500C5.7020803@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167695>

thanks all of you for your fast help. My problem is now solved.
