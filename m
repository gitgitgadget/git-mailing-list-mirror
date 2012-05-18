From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Fri, 18 May 2012 17:34:43 -0300
Message-ID: <CACnwZYepxGaFqDYNEn9uW1R=Rbi_45J6pERR54btAC_vF-rJUQ@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<vpqehqxmwpj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 18 22:34:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVTsv-0001mR-Te
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 22:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab2ERUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 16:34:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32989 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758749Ab2ERUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 16:34:44 -0400
Received: by dady13 with SMTP id y13so4284001dad.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZYMaiU2r40kbL9mqxzFSLRiGMxrnmDjjPAnvLwFSxPw=;
        b=US5Mx5m/AOPXxlxbhCdPm/yDEVRSNpcvosU7J7h+m1KD2pt7O0l8OOGb8wELEI72bT
         CpvKf1YpY+2OqhmX0X3B8Jj0jHl5tpF7uOi+iYlhIH4PS+C5f8lbQbcVJXOLm1uXPdJe
         i/FnV7W7h20ayk8YIF9TflE4Bqa3EoGCmG6oMwDZkOmk+NxbNY6f2Rtkx0kGKwlxuGdM
         ElvBnb7AlczNCWh/bFKOsz113uORKj55uSvq3J83U0Y2NjNUpxkfYMEqEOVVOtNg0nYx
         Qw9AVbUfGP43TOVLTQTJ1AEThqTGKY4jtneg3ZYBeM4GTc6ws/AqDOlQcPmgGQPjrVjL
         k3QA==
Received: by 10.68.197.99 with SMTP id it3mr10897685pbc.148.1337373283761;
 Fri, 18 May 2012 13:34:43 -0700 (PDT)
Received: by 10.143.77.10 with HTTP; Fri, 18 May 2012 13:34:43 -0700 (PDT)
In-Reply-To: <vpqehqxmwpj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197970>

On Sun, May 6, 2012 at 7:26 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> About the name, an alternative to "stage" was suggested earlier:
> "precommit"
Thanks! That was the first that explained to me what cache, index, and
stage was talking about. +1 from me (not that count much).
