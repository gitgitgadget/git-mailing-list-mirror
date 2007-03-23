From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: emacs and git...
Date: Fri, 23 Mar 2007 10:56:20 +0100
Message-ID: <38b2ab8a0703230256l5be8a558oe1daa6c5cd2ea16f@mail.gmail.com>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	 <86lkhpmftt.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230029h7f3faa95u1e2ccb6a9ee4be5e@mail.gmail.com>
	 <864poch0xl.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230132j64cf0b94x7c210593f3f31387@mail.gmail.com>
	 <7vtzwcqqf9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 10:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUgVV-0006b9-Fu
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbXCWJ4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbXCWJ4W
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:56:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:39428 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbXCWJ4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 05:56:22 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1029652wry
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 02:56:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VrbdIol/PgPdsEQweSwjMo7K8yzsWcmZJ0qC4L+p0vXYNgHXpQXLMSDQf3XXYuPRMAu9V0mcHZxymYV7lYHFUjs7NdQ+tvR5sLNfRJK1lLYvSAMPHm8cYxappEPqW0EW2Cmi2vtHIZLNz5DWZRYxy//Nn1f0jr7QZwMQxwawlsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JH2fpx+21dvSuUY4FpwIMsXOWk6U31s0O1Pg+wPFhC6azx6OAZIR9Lxb4B/D9TyNcg5aslfE2HzmB3smm1K+kmJhjK/Zz8VFsecF7v5tsx//El5GPBk1llFAWYil9ahI78hZdKP5cPd3cMuKWAWuMlW32DiaF8fU6iZcms3Zh1g=
Received: by 10.115.33.1 with SMTP id l1mr1106973waj.1174643780966;
        Fri, 23 Mar 2007 02:56:20 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Fri, 23 Mar 2007 02:56:20 -0700 (PDT)
In-Reply-To: <7vtzwcqqf9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42922>

On 3/23/07, Junio C Hamano <junkio@cox.net> wrote:
> "Francis Moreau" <francis.moro@gmail.com> writes:
>
> > Can't git make 'cat' the default pager when run on a dumb terminal ?
>
> IIRC, `more` works on a dumb terminal.
>

BTW why not making 'more' the default on a dumb term instead of 'less' ?
-- 
Francis
