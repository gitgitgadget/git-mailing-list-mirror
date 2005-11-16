From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Wed, 16 Nov 2005 08:01:38 +0100
Message-ID: <81b0412b0511152301s13944046lb2cbac95f4dab1fd@mail.gmail.com>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
	 <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se>
	 <20051115223340.GA3951@steel.home> <437A6B8A.8060905@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 16 08:02:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcHIc-0000bc-NO
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 08:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVKPHBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 02:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKPHBk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 02:01:40 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:46503 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750967AbVKPHBj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 02:01:39 -0500
Received: by nproxy.gmail.com with SMTP id k26so325418nfc
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 23:01:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A6auJHYvP0kDNNCDF2Z6r01zOUPUwPDC2+M4cS2LfAC95lJvsym6LJJbSUUepVIVyHrsgLYATlQIN4S8I/5WlRNvy/jUw4/SXyOYRYDCE+pU6FcmM0NGy91QrLukDWviSpz8ckh7kjKF7vhRmlKEeOk+BC26gcLPlwUKbCQ9HS4=
Received: by 10.48.239.18 with SMTP id m18mr296797nfh;
        Tue, 15 Nov 2005 23:01:38 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 15 Nov 2005 23:01:38 -0800 (PST)
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <437A6B8A.8060905@etek.chalmers.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12007>

On 11/16/05, Lukas Sandstr=F6m <lukass@etek.chalmers.se> wrote:
> OTOH, I might be wrong and it could very well be an infinite loop.
> Mind running it over the night? I won't look further into this in
> 20 hours or so anyway.

You missed by some minutes and I fell asleep :) Now, it is some 12
hours until I get to the machine with the lot of packs.
