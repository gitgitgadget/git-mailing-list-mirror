From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Thu, 9 Oct 2008 22:20:25 -0400
Message-ID: <81bfc67a0810091920gfec5f19j6828a3e5ec7b7065@mail.gmail.com>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
	 <20081009061136.GA24288@coredump.intra.peff.net>
	 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
	 <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
	 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <48EE1F58.2060707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 04:21:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko7dK-0000gr-8e
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 04:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYJJCU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 22:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYJJCU0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 22:20:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:34165 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbYJJCU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 22:20:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so330357rvb.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aOS3oKUe30+nS1Mvk9N6YNBH9M3PLXjQtS9GZexJmRU=;
        b=MfXB9UZ3NIfgGTieWNNvUtczyWjzW80C8ZqsSvNKlqKuS57HXIMyn/AoJbEjQgV9Q6
         deC4PVe1/73776UIQFG8EyfPe5iZnq3J7+VW73hhjqF6rYpdXu/P8i5f258M3any/suB
         +VQzj5rCNLtTzVXJ/gTU2zpI4h4jyrKzfuVEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TG/erDn45E3uSqdk3vDZUGAQvXSN44FOotXgKocu6Fy1Wj6sMsgg4CWD983SKBBBjE
         btIzDk524vvaeNHReWlLl8IXTjUgQvVNH2ds8dkWL7d/3sT+h0CXcEAM3kYibDOR2fQF
         4Ky46568569XOxcsZTNAKZWKFHSF7SYb7ehZ0=
Received: by 10.140.133.9 with SMTP id g9mr668440rvd.235.1223605225445;
        Thu, 09 Oct 2008 19:20:25 -0700 (PDT)
Received: by 10.141.145.7 with HTTP; Thu, 9 Oct 2008 19:20:25 -0700 (PDT)
In-Reply-To: <48EE1F58.2060707@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97908>

> Could you list exactly which options you want implemented?
--new --untracked --modified

I believe there are other states as well that I'm not thinking of off
the top of my head. Those should probably be included as well. another
option could be to have an option --filter=modified for example.


> Requests for stuff like that keep appearing recently
> ...
>  Michael

all way over my head


-- 
Caleb Cushing
