From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 22:02:35 +0200
Message-ID: <46d6db660707261302u26f5df3bwfdf6319b37087ce2@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
	 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
	 <Pine.LNX.4.64.0707261534550.14781@racer.site>
	 <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
	 <46A8D2BE.7070309@trolltech.com>
	 <fcaeb9bf0707261243v65f6e9deof8e266590e05d49f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:02:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE9Xn-0003ir-Ci
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 22:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933698AbXGZUCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 16:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758971AbXGZUCi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 16:02:38 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:39438 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933302AbXGZUCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 16:02:37 -0400
Received: by py-out-1112.google.com with SMTP id d32so1189571pye
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 13:02:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R8SiIkrFDmLlzQGoTPwuFZxKeGeOgIXYRTCy1YBa/dYlCSVY+bSPy3zHY2rHs7QRwvbezgN0XLcPypByg5Jeyc3lXaktCezum08gPycS2vSx2SwQSkJAFh9QEiO786qeJfrmUUdm0q0XHM8GR2rRkWGkkscazdErt/8vTSFhEo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A93nnoUJoAi1go6Tvqp/4y71rNruCTEo2oBC4yutpSBae6kCdZGmgymzP2TZumUPdYQxTRx9hwp4Ke8EH5ZiafYwj2YwYgW80PjJEMyhVRptiruWxKvjmaNpzgHhAIvmKi7SHCh7R/cQInnxojGuSpWG+tWfhk9jy2/dzY/ZNm8=
Received: by 10.114.177.1 with SMTP id z1mr2180539wae.1185480155412;
        Thu, 26 Jul 2007 13:02:35 -0700 (PDT)
Received: by 10.115.78.15 with HTTP; Thu, 26 Jul 2007 13:02:35 -0700 (PDT)
In-Reply-To: <fcaeb9bf0707261243v65f6e9deof8e266590e05d49f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53864>

On 7/26/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I cross-compile all the time (and test it on Windows when I have one,
> on the buggy Wine when not). I'd absolutely appreciate bug reports
> regarding building it on Windows ;-)

earlier on, when I reported a successful compilation and few problems
while committing, it was on XP. I'll be offline for the next 2 weeks,
but I can dedicate some time to your porting.

I second also what Dscho said. You'd be my hero too if porting
bbox over XP. Imagine "bbox + tcc + make + git"...

:)

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu
