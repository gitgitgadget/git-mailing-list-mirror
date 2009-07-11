From: devzero2000 <pinto.elia@gmail.com>
Subject: Re: libgit api & external integration
Date: Sat, 11 Jul 2009 23:17:20 +0200
Message-ID: <b086760e0907111417o4b249676jc821e8733d340c9d@mail.gmail.com>
References: <b086760e0907111409w602f4338u868729dcfa188908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 23:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPjwr-000625-20
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 23:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbZGKVRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2009 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbZGKVRX
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 17:17:23 -0400
Received: from ey-out-1920.google.com ([74.125.78.147]:32233 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbZGKVRW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2009 17:17:22 -0400
Received: by ey-out-1920.google.com with SMTP id 3so303845eyh.36
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=3tfbAo58+xosy/Iru49EO9NOd6qBuv4nsmSqqPJ7+nQ=;
        b=k6ESGbPKrrsXNekEbsfFTdXeVPyCMwGlNYglT48ubrllImyiQ8RosenTYPE7VaOVjB
         aRtpOldQQJCsgsvskVOJwmeITgCbArVWX/C2ICWb/4Zz56/upz1TW7/L7OPF0Re4gOgy
         O3RiPjc2xxFrHOexx7MQj88Oa5ReBKIZSWTbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=TWxiupnUXuYryPXcerYCFt9UufVWOD2wOSru8cTAWDy9mRvHechqp1o+LbcoHwHL93
         WFkvnrfl7DfnSidnpf98gRxarfhxHNycq550sKhffiU9hRTcF3JjM99qFSOCXhnHszXQ
         xBGaqz0mQoOP8UR4owPDIa0KEGi4Jj6nI8unQ=
Received: by 10.210.114.15 with SMTP id m15mr2902350ebc.90.1247347041013; Sat, 
	11 Jul 2009 14:17:21 -0700 (PDT)
In-Reply-To: <b086760e0907111409w602f4338u868729dcfa188908@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123130>

We, the rpm5 community, would like to incorporate in the rpm package
manager (rpm5 branch) a=A0 VCS - the history is lonk and probably not o=
f
interest. I personally have recommend git, for too much reason that
everyone on this list can agreed. Unfortunately there seems to be no
clear API or usable libgit to do this now: some comment on this ?
Thanks in advance.
