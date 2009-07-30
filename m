From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 02:10:15 +0200
Message-ID: <40aa078e0907291710j23695160q34541e4dc5943f3d@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
	 <40aa078e0907291705r65feae3au1dfc5b6400f4e434@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJE3-0003NJ-Ct
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583AbZG3AKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbZG3AKR
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:10:17 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:38346 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbZG3AKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 20:10:16 -0400
Received: by fxm28 with SMTP id 28so323546fxm.17
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=93plSPn1cljgPpWUXUA3j0igMcByGjSSZ/tgoFc1X+Q=;
        b=GI2jYqYaVyGhm67Ggej1pF8tCnKyrLnMsrKzlqIjIJmJrPqsnjZdhHzzY8zf/cujpA
         hUrO2o+g0UI1VcQykCK7NzMff2KgqI9DWzhBTnfxiOhBmiV/t81WiF6/MFAMx4MI7JQS
         ltlpDtc+QsWYqmLuk/shOIYWohPfIISrP4Cik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GboV1bHfYzZtxKexnTsLP3XmRjZjgP+22ERrLZ6/6PWSKZ2ojh6Iw2Qjctw4wsAV5X
         A+4wxbg/Vk/OaqwjtFlyAWe50sO9Y9ND1SHG/fompdgUwKVuO4auee0pSQyspPbVpIlo
         1xB5ESQOjuJ3Tlbc6ctLsYB4JZuLTy1CbcRuA=
Received: by 10.204.116.15 with SMTP id k15mr418976bkq.111.1248912615694; Wed, 
	29 Jul 2009 17:10:15 -0700 (PDT)
In-Reply-To: <40aa078e0907291705r65feae3au1dfc5b6400f4e434@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124417>

On Thu, Jul 30, 2009 at 2:05 AM, Erik Faye-Lund<kusmabite@googlemail.com> wrote:
> I'm having issues installing msysGit-netinstall-1.6.4-preview20090729,
> due to lack of libcrypto.dll during installation. The command promt
> says:

OK, this new netbook is neat, apart from the tiny keyboard ;)

I'll try again - sorry for the noise.

I'm having issues installing msysGit-netinstall-1.6.4-preview20090729,
due to lack of libcrypto.dll during installation. The command promt
says:
-------------------------------------------------------
Checking environment
-------------------------------------------------------
Environment is clean. Can install msysgit.

-------------------------------------------------------
Fetching the latest MSys environment
-------------------------------------------------------


...after that I'm getting a messagebox saying that git.exe failed to
find libcrypto.dll.

Checking in c:\msysgit\bin I find most needed stuff, but not
libcrypto.dll (or libssl.dll, which I suspect would have caused
similar issues if it wasn't for the lacking libcrypto.dll)


-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
