From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 13:07:34 +1300
Message-ID: <46a038f90602131607k63aa32abpa273b2325fc4b1b8@mail.gmail.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	 <87slqty2c8.fsf@mid.deneb.enyo.de>
	 <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
	 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
	 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
	 <43F01F5A.5020808@pobox.com> <1139810847.4183.85.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Ben Clifford <benc@hawaga.org.uk>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 01:07:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8njK-0002nD-FH
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 01:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWBNAHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 19:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWBNAHi
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 19:07:38 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:55169 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964858AbWBNAHh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 19:07:37 -0500
Received: by wproxy.gmail.com with SMTP id 50so977617wri
        for <git@vger.kernel.org>; Mon, 13 Feb 2006 16:07:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A3/YrObIgodJD4ph6UYxQvttoLPJ64iRgbIliQl0549uUKd7TOqw3ZfqvoF4GvKevfZHgGs6PXie1fy+KoMtASNi2dhB2AP4KrZsj4r1Cqmpp2AGh5MVU55UHGpL1DUJa+ofKKXch9tiuoCkg9ADz9it5YqEVn7ARNq3OW/RGBw=
Received: by 10.54.71.3 with SMTP id t3mr2871142wra;
        Mon, 13 Feb 2006 16:07:34 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Mon, 13 Feb 2006 16:07:34 -0800 (PST)
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1139810847.4183.85.camel@evo.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16090>

On 2/13/06, Keith Packard <keithp@keithp.com> wrote:
> and, named to include a hash of the contents

really? I thought it was something like md5(hostname+datestamp+random).

cheers,

m
