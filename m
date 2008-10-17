From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 09:25:06 +0200
Message-ID: <2d460de70810170025y74fbd846nefc7dad24f669e75@mail.gmail.com>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
	 <m3ljwojeeu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 09:26:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqjj6-0006zt-NH
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 09:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbYJQHZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 03:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbYJQHZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 03:25:09 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58146 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYJQHZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 03:25:07 -0400
Received: by gxk9 with SMTP id 9so727264gxk.13
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8vRDGaQiFEHnYUFQxyGdJUOWCv1eKnDLKuokAS1CCfA=;
        b=PFT5lkAtX89IrnV0GR2nFx+cftV+DocnxjC4UTIOVYNpcexwK+sc03SshLkAL0fkhQ
         kPg4eiPvkwkaoSQeDzRvco+ImKr8VjM8eGR+5uKedA1judW9DGQeNtGqutYz7dhrGpdO
         o3SwK7g77NL/1dO0l7ZFOORjTZrMEelPdfrng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DXctK9/fi6/eo3gE2bs3J379NzN797ZmbrVW1Gw7cxAPi6iiWJ6kdAIA/5aKCjTi58
         98ZLAj7iHI/GUH2ELzIrMVe9P5c1FYdI4fJVw09qMka5rv9Ho97IaAh2NyDyGXW/UMMw
         e/eG1o5ETjHVKxA9INP/QIXQ1gCJlMA/opoYU=
Received: by 10.100.248.9 with SMTP id v9mr4668610anh.115.1224228306337;
        Fri, 17 Oct 2008 00:25:06 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Fri, 17 Oct 2008 00:25:06 -0700 (PDT)
In-Reply-To: <m3ljwojeeu.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98454>

On Fri, Oct 17, 2008 at 01:42, Jakub Narebski <jnareb@gmail.com> wrote:

> [a lot of detailed information]

Thanks! 'Unfortunately', I figured all this out by myself, in the
meantime, but I really appreciate that you took the time to
explain all this .


Thanks!
Richard

PS: Well, I lie, I did not figure out the mv $1.sample $1 bit
as my git version still uses the old format.
