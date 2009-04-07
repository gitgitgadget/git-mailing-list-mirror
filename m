From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Mon, 06 Apr 2009 22:08:59 -0400
Message-ID: <49DAB5BB.1040100@gmail.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org> <49D542FA.3070304@gmail.com> <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de> <49D54799.9010607@gmail.com> <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de> <49D6B8C8.8090304@gmail.com> <alpine.DEB.1.00.0904061114420.10279@pacific.mpi-cbg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 04:11:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr0mI-0004pZ-26
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 04:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZDGCJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 22:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbZDGCJF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 22:09:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:52845 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbZDGCJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 22:09:04 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2422476ywb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 19:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=W8KYKlHQWFk5EeYgYQhI1zw5fSFGYEBtjAqtm7zwpr0=;
        b=M5Eh3CSwL48ElWC43aGQH3j8Ype91ZdwVpHTkuRB5uHmX4WlIfZQLakSckY55mWGnw
         XM1SEi3j9zfXq8CjbC49DCkWoxYZWTiulvXPY3qkBCIC0ydZi1md4NSQ463y5rIBxWMH
         vWgRRfNV7GK3ZEMmqAdGVL7KCbaFXXOIBBe38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=i5meGgy4P+YYnZtk0CWinoWSYzelYIoNV1qjGTRBEMpt/zKpyLzFDMQN80jnzysFq2
         lRKzCIwplOp63nEiLdOSs5D3VpMdcSThN0l0Xsa8iENj+JlJa348C/V0LqSUodikyF0R
         Y4molaarrRa5fgSHogk/6GgM7s79Hmm7DTxvY=
Received: by 10.90.117.17 with SMTP id p17mr3680173agc.52.1239070141726;
        Mon, 06 Apr 2009 19:09:01 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id 29sm7275775agd.57.2009.04.06.19.09.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 19:09:01 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0904061114420.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115899>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 3 Apr 2009, A Large Angry SCM wrote:
> 
>> Sorry, this is not a flame war (and as Peff already sent a response that 
>> superior to my own) so I'll let Junio decide.
> 
> Thanks for keeping a cool head where I failed.  My sincere apologies.
> 
>> However, to keep the peace (and as a thank you for all the hard work to 
>> date, I'll say that I'm scheduled to be be Germany and Munich the first 
>> 10 days in October and I'll buy the first $100 dollars in drinks at any 
>> meet that participate in (as a thank you to all the hard work for git 
>> that has been performed) that may happen that I participate in).
> 
> I'll take you up on that!

s/Germany and Munich/Berlin and Munich/
