From: "Abhijit Bhopatkar" <bain@devslashzero.com>
Subject: Re: [PATCH] Documentation: Mention that 'bisect' is reserved branch name
Date: Fri, 7 Nov 2008 15:53:18 +0530
Message-ID: <2fcfa6df0811070223w5631af5drdc34e6ea51bc566e@mail.gmail.com>
References: <2fcfa6df0811070201g75bfe659x38a4f14b1cf793c6@mail.gmail.com>
	 <87wsff269h.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Nov 07 11:24:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyOW1-0008KD-Oj
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 11:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYKGKXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 05:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbYKGKXU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 05:23:20 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:11659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbYKGKXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 05:23:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so561793wah.21
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 02:23:19 -0800 (PST)
Received: by 10.115.73.20 with SMTP id a20mr1245750wal.1.1226053398903;
        Fri, 07 Nov 2008 02:23:18 -0800 (PST)
Received: by 10.114.175.11 with HTTP; Fri, 7 Nov 2008 02:23:18 -0800 (PST)
In-Reply-To: <87wsff269h.fsf@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100300>

>> "git bisect" uses 'bisect' branch to carry out it's operations.
>> However "git branch" documentation does mention it.
>> Add a note that 'bisect' can not be used as generic branch
>> name by the user.
> Hmm...
>    commit 634f246444e6a1675e351f31362e6a375dc44f70
>    Author: Christian Couder <chriscool@tuxfamily.org>
>    Date:   2008-05-23 01:28:57 +0200
>
>        bisect: use a detached HEAD to bisect
Cool, didn't know that ...

Submitted patch must be ignored
Thanks

Abhijit
