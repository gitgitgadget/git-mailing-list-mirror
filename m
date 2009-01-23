From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Merging adjacent deleted lines?
Date: Fri, 23 Jan 2009 10:51:16 -0500
Message-ID: <76718490901230751uef27274sf7b44e6718f861ae@mail.gmail.com>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
	 <200901222113.31082.robin.rosenberg.lists@dewire.com>
	 <76718490901222318l7c3559ecje4a627fe2ff2ad12@mail.gmail.com>
	 <200901231132.36543.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 16:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQOKo-0000Pp-Rp
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 16:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbZAWPvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 10:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755179AbZAWPvR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 10:51:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:33086 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbZAWPvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 10:51:16 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4758347rvb.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zuo70SX40XVrcWs3ef5h5aRcEiRWbclX0wZ14pjpuds=;
        b=PFPpFDj07UpCPZDJ/KamZ73TDNy9Miq6CIBilSaDBc4ayTNqbyb6oXbLEXwBhVIbAf
         l1Lta+auuhVu0rQHM/RAk1PIZBaz746FHm9sx0tJN2s4FtiltKWb0rMysgw5TRGBOrsQ
         cBC0Fff1U+u58+82E0GAEK7LMvVaMDthjxyCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=edj//J80pCo+ctqMebp0w9QbvXtHo2KNjxh9tq+lc9SZpjol5f9RX3+u5fuPb/PutI
         G3hMrFGPGOF+AnbOWv50cYVVAFa2u8hhhjZ5wQBpi8T0zMrsv56eDJXYtc//AQimrBGH
         JektIX4GYHF50eCfOFNkG6UDc7zgjW/SzXao0=
Received: by 10.141.36.10 with SMTP id o10mr58653rvj.272.1232725876127; Fri, 
	23 Jan 2009 07:51:16 -0800 (PST)
In-Reply-To: <200901231132.36543.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106884>

On Fri, Jan 23, 2009 at 5:32 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> Where's the ancestor? I'm used to having four panes for doing three-way
> merges, but your screenshot showed only three.

I installed xxdiff to compare w/opendiff, meld, and vimdiff and I see
what you mean with xxdiff.

opendiff/meld/vimdiff don't show the ancestor directly, but they are
still using it in order to show how one version differs from the
ancestor in the left pane, and how the other version differs in the
right pane.

>> Shrug.
>
> You have the option to ignore me....

Doh, I meant only "I don't understand." My apologies.

j.
