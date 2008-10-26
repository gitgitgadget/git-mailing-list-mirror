From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Sun, 26 Oct 2008 22:18:57 +0100
Message-ID: <cb7bb73a0810261418y3b114e2ag81cbb75c4a80603c@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <gdqbta$rhe$1@ger.gmane.org>
	 <m34p32i83f.fsf@localhost.localdomain>
	 <cb7bb73a0810240401q57e40b9dj46c35f90681cfa3d@mail.gmail.com>
	 <m3k5bvgz83.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 22:20:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuD1x-0001i3-TU
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 22:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbYJZVS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYJZVS7
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 17:18:59 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:29292 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYJZVS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 17:18:58 -0400
Received: by yx-out-2324.google.com with SMTP id 8so472996yxm.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tXnXhP4XBoZYNKOPMUcV0Jp5MGCT8yHallHy7Ik0+pA=;
        b=wFolpG6UI8pws8MNFMHtO4HP5BgcZ0T9zA9JoCAF29YBVoyOyaGsMQP3LErnOBZk5m
         MQtghOumPdNcAg2tkzExAlBonz6fXfnGR88mofAVX0lDNgJoqnij48z07LqXB3Az6Fiv
         Ht2l/jAzPAafUv+TVZqQf1Vabb2jaNXnp4qHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YTSjigd1uk9t09YmJ/7+X4IXny18RXwdZhI+lDx8hCJ1QFO4k352L/e0hbUsH11wdU
         JOE0S7BFmaYRM4wmnpbnCKHkiz8ou/94tIbomNS0ERuhSnBZVu5cOHJSj5y8qw4uFCpT
         gD//4HHZkN3GaEb5DRI11Ax0AGPKYSlDw3TDw=
Received: by 10.151.50.11 with SMTP id c11mr10751597ybk.214.1225055937678;
        Sun, 26 Oct 2008 14:18:57 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Sun, 26 Oct 2008 14:18:57 -0700 (PDT)
In-Reply-To: <m3k5bvgz83.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99183>

On Sun, Oct 26, 2008 at 4:20 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>> Ah, good idea. Done, in Version Control Interface layers section
>
> Thanks.
>
> I have added link to repositoy, as you didn't configure your gitweb to
> display those URL links (see gitweb/README and gitweb/INSTALL).

Oops, right, thanks. BTW, isn't there a way to have the git:// URL be
computed automatically? Judging by the docs, it seems that I have to
set it manually for each project, like the description.


-- 
Giuseppe "Oblomov" Bilotta
