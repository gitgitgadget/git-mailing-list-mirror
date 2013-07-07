From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2013, #02; Fri, 5)
Date: Sat, 6 Jul 2013 17:35:31 -0700
Message-ID: <20130707003531.GG30132@google.com>
References: <7v4nc98jbc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 02:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvcxF-0005YB-3M
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 02:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab3GGAfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 20:35:36 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59460 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab3GGAfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 20:35:36 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so3153981pbb.6
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OOojoPc1bkSvPlD0AuZ5hXpW/J2F1uYvi50BIFOQDIo=;
        b=s4iFKETXR7z7awSU7u2NeYwR1dPcHfCUUYBB960ZpNXUPR47bFKf0dLOLOceVeAy+E
         qtPKNv+vyAFnr9rNysMSF8NOw+HEE6lTXkqOXvqNnUobEB8EG5yvS0y5Q8YXOfE5ANa0
         JA0rX6F3EfQGrGAAF9/fbdsUnrj0uTUMDsDt5Isp7xVq+5OOYz4GisWLtMfG2BpjVBde
         qfY6NhGsK1J/y0RA31ZlGxfjvK5T4haQIK0ruP/XBj8Hxe3NMFAkuOCyi+i6PxJUV8Kc
         4XKQDm7kRNIfECkeUgLZU9aewZVXJnFBNlTI877iobXvlIvZh3EEGw0BcrsN9yQVd6CQ
         8FGg==
X-Received: by 10.66.161.195 with SMTP id xu3mr17134975pab.56.1373157335238;
        Sat, 06 Jul 2013 17:35:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sz6sm15680087pab.5.2013.07.06.17.35.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 17:35:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4nc98jbc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229709>

Hi,

Junio C Hamano wrote:

> We are in the middle of 5th week now in the 11-week releace cycle
> for 1.8.4 (http://tinyurl.com/gitCal), and quite a few topics have
> graduated to 'master'.  I'd expect the rest of the week to be slow.

I'd like this or the next release to be 2.0, so the common user
trouble with "git push" pushing more branches than they intended can
be over.  Am I crazy?  If not, what can I do to help make it happen?

Thanks,
Jonathan
