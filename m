From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit 2.1 questions about range selection
Date: Tue, 1 Jan 2008 16:33:59 +0100
Message-ID: <e5bfff550801010733k63ed0c3du273f28b684efe904@mail.gmail.com>
References: <771EDDAF-F479-45F7-AB85-F7B6603FB061@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 01 16:34:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9j8Q-0004tm-BG
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 16:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbYAAPeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 10:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbYAAPeD
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 10:34:03 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:51468 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYAAPeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 10:34:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4934648rvb.1
        for <git@vger.kernel.org>; Tue, 01 Jan 2008 07:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rOU1r8r75d71MR98snxdHvWgu6mKpGR/qR4UnaqSidA=;
        b=GKTfDLQQ5Lk2fWRtCm+v9WXlwCyydgqJ5HrT7reLicjB9zUhOXu+zE+hRzcRQUsiWjNB5A6vRHnXPmgI9pMugZRvMe13GnPZeNFqWL4iFSdvQhb6SM4KK/KBfwEM8vYO2LF0SSOKSfqkBNEjqj7Yx3swEheXGky4e7lKK0XbuHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=yGmepz17ISu/IAgsAE7nb75Z9/Njgycf6ZjVi667ocngcxP+6b4zQ5feiv12blMOMUWJvZbdq5ISXp8a9ycojFlFXObFJN6J1UOF1qSAtIMAgb+BT8EgSSVvfBwD23ZaVK6Ee0inBJ4p65FGeYpsBt9emNKU8XUUUlKihoFwjVs=
Received: by 10.141.161.6 with SMTP id n6mr6829713rvo.201.1199201640025;
        Tue, 01 Jan 2008 07:34:00 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 1 Jan 2008 07:33:59 -0800 (PST)
In-Reply-To: <771EDDAF-F479-45F7-AB85-F7B6603FB061@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69439>

On Dec 31, 2007 11:42 AM, Steffen Prohaska <prohaska@zib.de> wrote:
>
> Here is a first impressions and some questions about the range
> selection, which I find pretty hard to understand.
>

Hi Steffen,

  I have just pushed to

git://git.kernel.org/pub/scm/qgit/qgit4.git

a patch series that should address some of your concerns.


More questions are welcomed ;-)

Marco
