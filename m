From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: The 9th production of the msysGit Herald
Date: Wed, 13 May 2009 13:29:04 +0200
Message-ID: <81b0412b0905130429s1e6eb8a6gfc62e78540404746@mail.gmail.com>
References: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de>
	 <81b0412b0905130237h3bc29c80od4a8a8ad12a972a7@mail.gmail.com>
	 <m3d4adl4cl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 13:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4CeC-00035x-Ku
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 13:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759423AbZEML3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 07:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759848AbZEML3G
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 07:29:06 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:32832 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759401AbZEML3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 07:29:04 -0400
Received: by bwz22 with SMTP id 22so578629bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=njZ/8d/EeJsM9zM64/YSV5ahbjVq/9qIdxhQUTCdxk8=;
        b=t4YLcRAqUbNcQLkh7wF3curh/lkU+PaoxdLdsSkUc+xDkOcRKJYxHjqVLuiV+STOla
         ZW5P+5ne9PpsfLixOMt0gBfmAOHfTJGN6AFOEV0Nq3753VOvnRxO8Z+tTXJI9lQp65tH
         MJUnqq+SgMjYB/OdZb9uRq0A90ReHQr5pBmkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C34sVgRPJcjYyxckY6rcpMa/MH2GRbLAw1xTjin+LGn9HsaiPYGhuv+ro4duqjI1Cr
         yeWiy9gcWbZq0wOsBS/szfuS++rxZBftWRM4paB6JJXfUCxuwmv/wtljrcnZWfWxZga2
         VHet3f3ershZTMScryCQYk/eTuo/DAk1D2uCQ=
Received: by 10.204.72.129 with SMTP id m1mr838158bkj.61.1242214144772; Wed, 
	13 May 2009 04:29:04 -0700 (PDT)
In-Reply-To: <m3d4adl4cl.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119034>

2009/5/13 Jakub Narebski <jnareb@gmail.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>> 2009/5/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
>> > I will delete comments on the Wiki that do not contribute value, I
>> > will delete comments on the Wiki if they are just not comments but
>> > insults (and I will even delete commants that are useful after
>> > addressing their concerns), I will remove comments on the issue
>> > tracker that I do not like because they are abusive or just rantin=
gs,
>> > and I _will_ delete all mails in the Google Group that I find
>> > offensive.
>>
>> You can try to setup bogofilter (the spam fitler) or spamassassin on
>> the comments. IOW, I fully expect you to be overwhelmed with all tha=
t
>> housekeeping one day.
>
> Errr... spam filter wouldn't help deleting insults / abusive comments
> / rantings...

But it would help deleting spam. And I suspect many of the deletion
candidates follow the same scheme and use very similar dictionary
("What a stupid tool, look at Microsoft UI Guidlines, SVN has it, ...")=
=2E

>=C2=A0Besides, wouldn't Akismet be a better solution for
> anti-SPAM on *wiki*?

Interesting...
