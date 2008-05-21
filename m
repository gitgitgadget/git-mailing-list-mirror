From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Wed, 21 May 2008 06:44:09 +0200
Message-ID: <bd6139dc0805202144h2bb55fd1n9b26bc76c245f33b@mail.gmail.com>
References: <48329282.1040407@tikalk.com>
	 <20080520093245.GA5037@mithlond.arda.local>
	 <bd6139dc0805200310j13a9b74dy9f28fe855c59e01b@mail.gmail.com>
	 <alpine.LNX.1.00.0805201748020.19665@iabervon.org>
	 <bd6139dc0805201525r22ba7398g6f341f89ae699b57@mail.gmail.com>
	 <alpine.LFD.1.10.0805202105430.3081@woody.linux-foundation.org>
	 <46a038f90805202126s80262d3i2f4f940a38d9ea06@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 06:45:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JygCF-0005P6-GI
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 06:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYEUEoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 00:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbYEUEoM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 00:44:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:42654 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYEUEoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 00:44:10 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2047252wfd.4
        for <git@vger.kernel.org>; Tue, 20 May 2008 21:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aTxrWaauISa20U2B+Ugxpt7+PhDyScxJZVpAyOI0tXw=;
        b=AWiudYT47f4WfLlYeozVQJ3fe6xYMBdeP6BMh/8vSUDGcjDpGOPG1XglkbB4WfX7XlhCEDZovRxLU0lDs0JQaPqF4pWBVMXoS1GgWtpvHxgVrxI7KLRY2AssOs4eg4e8zY8jtC2zLhGlwZpQBpfjodCzuPGKaJXxfu+LW/pwPXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S5Y3G+g9pPfXsRSaPA4ozfujaWx3pjf3xyiaL6HRpiLFI9U4TCJBfshU4bdofKPaKShqza9ExCvkAtIoEE3bm0G1TL06QFb7azS3wFDSn3KrKxq5/eDHCidV7/Ox0B75ga/xzeagMZ7UIERRIjbPjIOnyY9fJ4fGkY0FGICiv3o=
Received: by 10.142.52.9 with SMTP id z9mr3677579wfz.201.1211345050238;
        Tue, 20 May 2008 21:44:10 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 20 May 2008 21:44:09 -0700 (PDT)
In-Reply-To: <46a038f90805202126s80262d3i2f4f940a38d9ea06@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82523>

On Wed, May 21, 2008 at 6:26 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Heh. And trim it to start on 2005-7-12 - the date of the first debian
> package for it. Makes the graph more interesting.

Trimming it does make the graph a lot nicer although doing prevents
you from comparing the grow curves (of CVS and SVN with those of git).
http://tinyurl.com/6hj5ds

> Do I confess I added tla to the list too? Some things in my past I
> rather not talk about...

I'm afraid 'tla' is too insignificant to be of interest :P, it's
steady at, say, 100 users.

-- 
Cheers,

Sverre Rabbelier
