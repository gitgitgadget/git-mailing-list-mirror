From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Tracking files across tree reorganizations
Date: Thu, 15 Dec 2005 18:38:02 +1300
Message-ID: <46a038f90512142138x77e57850ib095c1d68ecdfd13@mail.gmail.com>
References: <43A08B8F.1000901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 06:40:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emloh-0000vr-EL
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 06:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbVLOFiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 00:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbVLOFiE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 00:38:04 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:62059 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161124AbVLOFiD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 00:38:03 -0500
Received: by wproxy.gmail.com with SMTP id 57so285770wri
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 21:38:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FGFhdxPojwuAsAmGjUWKN+mLKStKLwUYQPomrtZDZJCGwDagO8GwRZTOHmuIh9h2sPiXD2dPgyvkFHlA2uXIp2qwaJyaD8TtQDEbfJvY0tmzPvgR+y+rJg1PLFb7Ir2OSNJlK741Ow1LM/HPnCfT5S5Twxnmkr/HiEK2Br/jTDM=
Received: by 10.54.69.8 with SMTP id r8mr865285wra;
        Wed, 14 Dec 2005 21:38:02 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Wed, 14 Dec 2005 21:38:02 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43A08B8F.1000901@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13679>

On 12/15/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Did anything ever happen with that?

Perhaps I'm slow today, but git-merge -s recursive was supposed to do
it transparently (automagically). At least it was merged into git with
that excuse ;-)

Does it not work for you or am I missing something?


martin
