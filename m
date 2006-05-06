From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Sat, 6 May 2006 14:46:31 +0200
Message-ID: <4fb292fa0605060546g54d8226ake4a91e8a30e0b2f1@mail.gmail.com>
References: <20060505005659.9092.qmail@science.horizon.com>
	 <20060505181540.GB27689@pasky.or.cz>
	 <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org>
	 <20060505185445.GD27689@pasky.or.cz>
	 <7vr738w8t4.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605052353m2d2aca11weac7efee80c6fb35@mail.gmail.com>
	 <e3hjfk$bjn$1@sea.gmane.org> <7vslnntxay.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 14:46:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcMBA-0003zu-No
	for gcvg-git@gmane.org; Sat, 06 May 2006 14:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWEFMqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 08:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWEFMqd
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 08:46:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13520 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWEFMqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 08:46:32 -0400
Received: by nf-out-0910.google.com with SMTP id n29so634913nfc
        for <git@vger.kernel.org>; Sat, 06 May 2006 05:46:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TU9fhEEwU0TyZW5oiFxufUqtNzu2rElzbixZdCS1u/wYDRRTjRKxfoyE2XOdiRQNTn6m4/0n2G1LlJtf0iZc+rdck3TurBwp5wYcu9dDvzdlh+WiZZEVWrvIIxEf27X3hQbn0HE6/WnLLFCKIoP6zr7ErQGUc08t2TmU4wCvQ9o=
Received: by 10.48.42.15 with SMTP id p15mr32420nfp;
        Sat, 06 May 2006 05:46:31 -0700 (PDT)
Received: by 10.49.2.19 with HTTP; Sat, 6 May 2006 05:46:31 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslnntxay.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19657>

On 5/6/06, Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
> > Perhaps an option to do rename detection with walking the commit chain?
>
> Have fun implementing that ;-).

I agree that it could be interesting to have a such thing. But that's
increndibly stupid and moreover a rare case.

--
Beber
#e.fr@freenode
