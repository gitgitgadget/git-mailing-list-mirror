From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: Problems Cloning an SVN repo.
Date: Tue, 9 Dec 2008 14:41:26 -0500
Message-ID: <c115fd3c0812091141m21738cew428872e3f9d6df97@mail.gmail.com>
References: <c115fd3c0812090954n6e5e527anadf04936e1ca01f@mail.gmail.com>
	 <eaa105840812091009k292ced25vcd638808c913b76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Harris" <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:43:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA8Tn-0004mY-Ri
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 20:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbYLITl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 14:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbYLITl3
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 14:41:29 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:39058 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbYLITl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 14:41:28 -0500
Received: by yx-out-2324.google.com with SMTP id 8so65452yxm.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 11:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OG0BjxHx/g90lr4+Hbx+hvW2Hn8b6L/QHWlZnKyiGmk=;
        b=v7VsAKBBXEtYQCjzbhEu62+SXADVycOIsoZfb5zNNWoe+y1tExUEtFJEJLOrh32Bvq
         dQ8f68z1AYOE2JK7FVA6FEXNSAL4Kl0Thr1NAei9MhaszE4RqqIpMWOAelm12w/PUTn6
         9oHLMzcRBoAglpjE9ItgxkLiKK32Ht3ob9adg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QZ6OSPNzEEx5eORdxqEy9ksm4/q/p2O+S+MobyNJvpytyZUcBw1tKEz8C4Fj6VXdqu
         AZkNLLpey3WZf4fyJ0hPydYtvvpOlomaP8wKSC+f+TpDUpoL7Zrn+otG38aAJ8GSn4qb
         LQQHZhQ5s7paVvPygannH0qtyS9dbJl8Md2pg=
Received: by 10.100.196.17 with SMTP id t17mr463598anf.84.1228851686994;
        Tue, 09 Dec 2008 11:41:26 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Tue, 9 Dec 2008 11:41:26 -0800 (PST)
In-Reply-To: <eaa105840812091009k292ced25vcd638808c913b76@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102651>

> Did you install the subversion-perl cygwin package?

That was it.  Thanks everyone!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
