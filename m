From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-1.5.5
Date: Mon, 26 Feb 2007 20:29:10 +0100
Message-ID: <e5bfff550702261129p5085bd22gae11c81b401d3591@mail.gmail.com>
References: <e5bfff550702250958n6cddc5b5lec4badf1f7fc8231@mail.gmail.com>
	 <46a038f90702251623h5944a085m514418cb5f530e7f@mail.gmail.com>
	 <e5bfff550702252219m352c03ady2d810e051bd62a37@mail.gmail.com>
	 <Pine.LNX.4.63.0702261218430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702260939t4a071d34o6bbf3dcd4ad5b67c@mail.gmail.com>
	 <Pine.LNX.4.63.0702261846010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlXC-000177-J8
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbXBZT3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbXBZT3O
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:29:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:13269 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030406AbXBZT3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:29:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so890903uga
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 11:29:11 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YVsRoMpKgp09Djril5dClnATJhbP/dezhBo2iOO+Nu0qQn3z41n6+1Fmj+hDjxnPhTgN+jcF2yJfJxf0x31gdlBEMiEOdanzvqdGTgUC251v1yaOZCbn9uSw/KdzA0vGxfXbeERG8ENi1eQu1kVM+Heej0UVaWHciHTQQc1uHNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fq/FwTJAq/v7+uXhEc9bjiu0YVgK1NIgptKQ/1hDOvVzdNCCRrUW5g4T4Unn1cmCpFH0n6L8GN0iYMC7Iajz9gFxOg6W+cx5IfCJ8kxlgCqwH/mp/Ur0cW6/B/bafi48Eb18bJ3SmKe4YqOL7/uV5cnX+/obMfzVX7W3GX92bRg=
Received: by 10.114.151.13 with SMTP id y13mr1479346wad.1172518150232;
        Mon, 26 Feb 2007 11:29:10 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Mon, 26 Feb 2007 11:29:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702261846010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40646>

On 2/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 26 Feb 2007, Marco Costalba wrote:
>
> > Actually, I didn't test with MinGW port of Git but I would be surprised
> > if it doesn't work (famous last words ;-)  )
>
> You don't use cygpath to translate between Windows <-> POSIX filenames?
>
> AFAICT this is the single most important user-visible difference between
> Cygwin Git and MinGW Git.
>

I call git programs as if they were native windows programs. I run git
programs without requiring cygwin shell or something similar.

I hope I have understood correctly your answer.

Marco
