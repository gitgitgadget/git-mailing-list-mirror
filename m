From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 20:47:46 +0200
Message-ID: <48404BD2.6040703@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com> <200805301202.25368.jnareb@gmail.com> <4840166C.3030903@gmail.com> <20080530150713.GG593@machine.or.cz> <48401CFF.4020702@gmail.com> <20080530153822.GH593@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 20:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K29el-0004FU-NL
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 20:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYE3Srw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 14:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYE3Srw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 14:47:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:2915 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbYE3Srw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 14:47:52 -0400
Received: by ug-out-1314.google.com with SMTP id h2so373591ugf.16
        for <git@vger.kernel.org>; Fri, 30 May 2008 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=WEUcMKXSEvv7uzx+mxsGoQuO97DjwWBh6j6y9qziM64=;
        b=uCk4vuXjKl4ZkJsLpE184yAADVCgvKsnHf1llAZ8nnVw6IOb4hpoHt99pP/TSvkWwxtpUwjpnXnoKyePBlcjzuZv3Xu/WmaAgg/Et5Gq0tVI0SnQOdhWJLHXTPgxtj9PPrkPpd4ma2XwLf50dBj48Cy0jBaX0pfAHjnGo5Tsxn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=FfNEuAGFuffQ/HfpKLw86QuZ+X1IKhRqS6sLZIu5Hpl8amq6xZyBA9sEWRA7tRLRvoB60gIjSBHSQfFjyEjT+SiuIAq8S+RD/0Azm+ToJG2OK/A83/RmhGG4aTuzXh5qCIWBFkb8fkhTqMgpNFpWrQVt/3v5GjIzx8+EzWw2umg=
Received: by 10.86.54.4 with SMTP id c4mr1225845fga.33.1212173270428;
        Fri, 30 May 2008 11:47:50 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id e11sm188928fga.4.2008.05.30.11.47.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 11:47:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080530153822.GH593@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83318>

Petr Baudis wrote:
> [5.8] is still too widespread;

Okay; I'll keep testing Git.pm and Gitweb with Perl 5.8 then.

-- Lea
