From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question about announcing it
Date: Mon, 6 Jul 2009 13:16:23 +0200
Message-ID: <200907061316.24824.jnareb@gmail.com>
References: <200907030130.24417.jnareb@gmail.com> <94a0d4530907051312u1c4bc811i4015b1eb753a8b1e@mail.gmail.com> <4A51B25C.9040904@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jul 06 13:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNmBf-0008MV-Ar
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 13:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbZGFLQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 07:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbZGFLQc
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 07:16:32 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:38040 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbZGFLQb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 07:16:31 -0400
Received: by fxm18 with SMTP id 18so3985852fxm.37
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uyHMy6VeWTQYS0PUlSBglNb/OAHCizyzbIi0t071QNA=;
        b=eG1mYMSsrN2qjSgH1z4GA/+O1ANvx+tLFmJ11FNpbJ4hQOcPY3h82X0EQSKKCVO6hU
         k1LLcASxzjR62vmWX2roTXY+Y/1/yFqMrKAp7hUkJtD29BHpWa40VtUnAgDSLvQpgej2
         FW4PaXP/4Uas5rWmbmEu3RR2FN96eXQXrCwfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qyOMrMe3OowQgbTqb1OSYN5vi/ticJ08pJ2ZtXhoFVP1U1HGSyW3SM6Fj9soZYuXTj
         7Y6A46nnKo0wBTcBQ/RlZNsHTpi065gay5t5X00N9CrGeEIy1m4P8Vd5cWQCivEzuVnV
         8ZyUOK+7DA+meVZF3333qrN3ADuPRH0zFFE1I=
Received: by 10.204.62.135 with SMTP id x7mr4468179bkh.95.1246878993638;
        Mon, 06 Jul 2009 04:16:33 -0700 (PDT)
Received: from ?192.168.1.13? (abvj223.neoplus.adsl.tpnet.pl [83.8.207.223])
        by mx.google.com with ESMTPS id 22sm11200333fkr.30.2009.07.06.04.16.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Jul 2009 04:16:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A51B25C.9040904@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122782>

On Mon, 6 July 2009, Andreas Ericsson wrote:
> Felipe Contreras wrote:

> > And I have many friends who don't follow git's mailing list, so no, I
> > don't think a mailing list is enough for official announcements.
> 
> There are no forums suitable for everyone who are interested in git
> development. We can (sort of) rely on package maintainers for the
> various distros to keep track of groundbreaking changes. People who
> compile from source are sort of on their own if they don't want to
> follow the mailing list or in some other way find out what's going
> on. I don't have a problem with that, and it matches what I'd have
> expected myself if I was building something from source.

People who compile from source have RelNotes since 1.5.0.  They are
here for a reason...

-- 
Jakub Narebski
Poland
