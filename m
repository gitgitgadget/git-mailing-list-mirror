From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Google Summer of Code 2009
Date: Thu, 8 Jan 2009 00:40:09 +0100
Message-ID: <81b0412b0901071540y3ab3dea7of1ad59f7a025c60c@mail.gmail.com>
References: <20090107183033.GB10790@spearce.org>
	 <81b0412b0901071512k64a7d5e2u2c602b903f5233d3@mail.gmail.com>
	 <20090107231431.GC10790@spearce.org>
	 <alpine.DEB.1.00.0901080024170.7496@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 00:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKi1l-0004E8-58
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 00:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbZAGXkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 18:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbZAGXkM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 18:40:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:42822 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZAGXkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 18:40:10 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4450326wah.21
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 15:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k+8PUfb5A8GPNp4p26NXj1yL6kd3akhxmD0uozGbNIQ=;
        b=vO7r2E4rL095qnERrlPMzSb7gemtD6y3kR6q/zIOJqj6wqM+oXuumBAPmgamWNlnOv
         Lf//N/BNDRvl8HAmef7AeYH9iQVJhtKmFKyK68p56wEziB3vs/8BdXy9P1sXQk5Izfda
         eFEZX+w7Z+BZ5qXJ6xEJTVUFExI1STT2bY09c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aqVc1QAB+hJTE+VFfxrttgrNpfojT4UWP2Uyr7La3+tAeNwhwEnlkg6td+2fUBNy9d
         +Hf837vZjsU5DFjrb+Q2QKuU2CpGDFYLvBB2/hlAXiNuN8vEVlRFwsfoB1xjTkUi8s7H
         XV94I9NoQhziHSs2TOs0GlJA5YrBOsTCt+8+w=
Received: by 10.114.146.6 with SMTP id t6mr15619714wad.207.1231371609880;
        Wed, 07 Jan 2009 15:40:09 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Wed, 7 Jan 2009 15:40:09 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901080024170.7496@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104851>

2009/1/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> GitTorrent and restartable clone both should probably be on the 2009
>> idea list, though GitTorrent already has a code base from the failed
>> 2008 project that someone might be able to start and pick up from...
>
> According to
>
>        http://repo.or.cz/w/VCS-Git-Torrent.git
>
> Joshua is still working on it (albeit slowly).
>
> However, from what Sam said at the GitTogether, it might be a much better
> idea to look at the existing code as a fact-finding experiment, scrap it
> (excluding the experience), and start modifying git-daemon.

Takes courage, saying things like that :)
