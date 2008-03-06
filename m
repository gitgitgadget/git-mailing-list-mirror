From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [ISSUE] git send-email sends wrong patches and non-provided CC (probably bug)
Date: Thu, 6 Mar 2008 17:19:14 +0600
Message-ID: <7bfdc29a0803060319v1f3ee295k44c1eecb6fbf1ca3@mail.gmail.com>
References: <7bfdc29a0803060111vc98ef42q96c3ce343fef0859@mail.gmail.com>
	 <7vskz4cfyq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:19:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXE8i-0002vG-8l
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbYCFLTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbYCFLTR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:19:17 -0500
Received: from hu-out-0506.google.com ([72.14.214.239]:15393 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbYCFLTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:19:16 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1275367hue.21
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 03:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qfKT9vEmftfBDjleWGMl2soqiB6M5bYKthYoumKSSfw=;
        b=VQj8TXhl1eQng8U56TWxRelplSt3vuFFAwPPiSkK0TQzyIF11jotpu8WIcUuecM/ub/oWX5dqr6FhtCmx11+ur/UBb7TaCXfIgTk5+osLXUWh41luvN9ydhCEkrn/1AIBHaeBZ5+Ed43nEsV7PI24BjFXHZ4Y8P53x7aJkLhh0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RB0jUPVf7VMuloVTCgKZxzfxa6FMW45GIrJPa6iphxFGBFdJqRCQlav7Mmq3r2DSxif6mlFuUzwLbtzdoMLhCklKTej0B+uiOGahQ9p0ZRIjtnkMZ81tqd2nFTcs+uvYGsmdZ7ZQPwDAc1rmJ3XmK3ICLwRU5l1D0efKuUE0UnA=
Received: by 10.78.90.10 with SMTP id n10mr9699831hub.79.1204802354439;
        Thu, 06 Mar 2008 03:19:14 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Thu, 6 Mar 2008 03:19:14 -0800 (PST)
In-Reply-To: <7vskz4cfyq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76374>

On Thu, Mar 6, 2008 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Imran M Yousuf" <imyousuf@gmail.com> writes:
>
>  > 1. git send-email sends CC to gitster though his email is not mentioned.
>
>  Check your config first.

Can someone help me where I can find it in the config? because I
surely did not make any change to config of GIT project. I would be
grateful for the help.

Best regards,

Imran

>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
