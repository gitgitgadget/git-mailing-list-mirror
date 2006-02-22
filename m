From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's in git.git
Date: Wed, 22 Feb 2006 14:46:46 +0100
Message-ID: <81b0412b0602220546k95d3b6ar35bb770e6e9c43e4@mail.gmail.com>
References: <7v8xs3pt8c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 14:46:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBuKV-0001WJ-HZ
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 14:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWBVNqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 08:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWBVNqs
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 08:46:48 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:29931 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751282AbWBVNqs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 08:46:48 -0500
Received: by nproxy.gmail.com with SMTP id l24so923898nfc
        for <git@vger.kernel.org>; Wed, 22 Feb 2006 05:46:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Knwyc40KNISNHHAp17xg0N4jW3tY0E7jGzbyMC3a3/7CJamfdy62HMIDH0cJ2SwaGMvJkwzWQRS0KsuHF92177sCY4/75m7hA9xM9JNh2xkk4bXobZqbYHyooggLZOssPEdlWx3SRdjBNi7E0oWlwjaFS+VtVfh5TU7O73JeZT0=
Received: by 10.49.18.20 with SMTP id v20mr1859889nfi;
        Wed, 22 Feb 2006 05:46:46 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Wed, 22 Feb 2006 05:46:46 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xs3pt8c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16598>

On 2/22/06, Junio C Hamano <junkio@cox.net> wrote:
>  - Perl 5.6 backward compatibility.
>
>    Alex Riesen volunteered to further work on porting the
>    "allegedly 5.6 compatible" constructs these patches use to
>    work on ActiveState (whose 5.8 does not grok them).  We'll
>    see what happens.

Well, I'll have to.
The alternative is Perforce which is too much pain to explain...
