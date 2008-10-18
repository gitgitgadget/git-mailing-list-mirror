From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [Q] submitting patches from gmail
Date: Sat, 18 Oct 2008 17:20:57 +0300
Message-ID: <94a0d4530810180720t417769edi9c64b8d239e77260@mail.gmail.com>
References: <ee2a733e0810180508m466f3ea1i9c63b47177f6e12d@mail.gmail.com>
	 <gdcm3d$f3k$1@ger.gmane.org>
	 <ee2a733e0810180712k42a4dbb6m3d4e9de717a79b53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 18 16:22:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrCh6-0004Ly-B4
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 16:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbYJROVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbYJROVA
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 10:21:00 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:6708 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYJROU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 10:20:59 -0400
Received: by ey-out-2122.google.com with SMTP id 6so358670eyi.37
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L164SiZhOelccddRp1en7zwUl5BtkqIENq2Q+HCfzx4=;
        b=SAe+NaaoS+kqKF/RvISpRcG1X/LmIGW4YX9aP6NbL3MX3khZL8jIh7rqCLFHGbV84q
         fiZMp0+LEIQiM/+4+/0f/MKht23hs3pQuSNw6bb93pyjnz57+EFiM+NVsmPVlV8WStqH
         W9VHtuUEWcooETV++IBMTZR+j/AeR32KVe60U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TlXtjOjfeqglcAx8SZZaeyoBJcCm3HizIF5qepAVgFwV/h0OrUe5k9yah95s5EfUsG
         8ObRNJLy0n3rcA7k9vGnlwu6gE5Wxto7IDXsfQBf1wEwM4UDDF2sMX/dR7cxQwEym2Ns
         OXqqC1UR+gpinkqv6RMnt+v6V5LFuAknyVz5U=
Received: by 10.210.105.19 with SMTP id d19mr5998380ebc.5.1224339657937;
        Sat, 18 Oct 2008 07:20:57 -0700 (PDT)
Received: by 10.210.24.18 with HTTP; Sat, 18 Oct 2008 07:20:57 -0700 (PDT)
In-Reply-To: <ee2a733e0810180712k42a4dbb6m3d4e9de717a79b53@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98553>

On Sat, Oct 18, 2008 at 5:12 PM, Leo Razoumov <slonik.az@gmail.com> wrote:
> Giuseppe,
> Thanks for the help!
>
> BTW, what is  /etc/ssl/certs/ca-certificates.crt and how to generate it?

Your distro should provide that along with openssl.

-- 
Felipe Contreras
