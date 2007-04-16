From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs repository moved...
Date: Mon, 16 Apr 2007 20:51:13 +1200
Message-ID: <46a038f90704160151q2121086bx1b224804d93ba481@mail.gmail.com>
References: <46a038f90704160032m9cfee8ai9830c81dd4a64cd6@mail.gmail.com>
	 <20070416075829.GK2689@curie-int.orbis-terrarum.net>
	 <46a038f90704160139o4a474876qfd5b3a6e21df279f@mail.gmail.com>
	 <20070416084238.GL2689@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Robin H. Johnson" <robbat2@gentoo.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMvi-0005p8-Ld
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbXDPIvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbXDPIvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:51:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:17159 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030187AbXDPIvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:51:14 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1535896wxd
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 01:51:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rq5xBHsl/83mucH6wLgf071g6H3liGA55azbu5t/kGGUtaw3YYuOUXrFjaasWnXNDcz/uR63W3+9NmNCTWloxdAJTnuesUVPAtGAt4wTVzlncFgh74M/k5MZB1hZ/GWDy/myedfBq8xBX6OnUfFWS43jzAlXDfhw4ReHFxcZCh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QhTAhhKz+UW5b6T+0Aog/DzCEw35jnaOx8ml1OFhiaEBbZcJ/SA86CW/PDCy7SY55p4BrLSVUtNE8W7JYYr1Pjw4XMbcknl8Z8ZKHYYurhYzIsRLwHH9TPPATgP8S3xiuQC4aoVIkhSQiacJtGsDEZmcyTwUa1x/v7lqwOrJvKI=
Received: by 10.90.35.15 with SMTP id i15mr41521agi.1176713473478;
        Mon, 16 Apr 2007 01:51:13 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 16 Apr 2007 01:51:13 -0700 (PDT)
In-Reply-To: <20070416084238.GL2689@curie-int.orbis-terrarum.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44630>

On 4/16/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> No, it's correct in this case. I have it configured to collapse any
> occurrence of my address into the list address, because I'm subscribed
> to the list, and prefer to not receive duplicates.

OTOH you _are_ breaking the reply / reply-all convention that most
people use and (almost) all MUAs handle correctly.

This means that I have a practical way to address you in private by
just hitting 'reply'. Most mailing-list-adept users will do that to
send you a private reply. It's pretty ackward that you are seeding the
reply-to with bogus addresses. I'd guess it'd bother me less if you
set the reply-to to /dev/null.

If you'd rather not receive duplicates, you can probably filter out
for duplicates in by message-id at your MUA/procmail.

> Gentoo Linux Developer & Council Member

Oh, well. And I thought reply-to flamewars were exclusive to
debian-devel. They are silly enough there.

cheers.


m
