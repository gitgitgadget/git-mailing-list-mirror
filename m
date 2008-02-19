From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 11:27:43 -0800
Message-ID: <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <20080219063937.GB3819@glandium.org>
	 <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
	 <alpine.LSU.1.00.0802191115440.30505@racer.site>
	 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>
	 <47BB1EC0.601@freescale.com>
	 <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
	 <alpine.LSU.1.00.0802191916020.7797@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jon Loeliger" <jdl@freescale.com>,
	"Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:28:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRY8a-0004KV-Is
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 20:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbYBST1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbYBST1p
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 14:27:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:37291 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbYBST1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 14:27:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3653975wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2K8CcJUoQYGUQIBh1WIa4bHBKZ08YVoWRR4Mwl3zgYM=;
        b=H/wRO/CURHi+vbKb4dz23hyXUrhzdSEQDsMJQH86BX41p5dHjV15gYnagxDWgj2r55ptVLWVqFpDvygJ6KQ9A/0i9Sk4hRcDixrPs8EG5aoxnGPhlN0rAUL3I+wvkLxkmmI7xP9gVrhbV9ychUYQB2MnolN8rwDI6QVjoed+VBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NfJPR1CQPAOFtS824BQj+FIeku2z/0ZnUJkbk8IkP0bSYCCiXunGyZhExXuja77RuLpjVcq9JPy8Z67Uk4cBullWIH6ayERW5XH2+AaAUDLHA+6v4lwEwuTUIOpNFLhPtnVoKM0+eL01qyJCJ+4s68W9+a3hlHG5gZ7TS9oeNHQ=
Received: by 10.115.46.9 with SMTP id y9mr4410288waj.129.1203449264015;
        Tue, 19 Feb 2008 11:27:44 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Tue, 19 Feb 2008 11:27:43 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802191916020.7797@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74447>

> You can.  But please understand that there is a difference from having
> cloned from somewhere, or setting up an uncloned repository.

ok, so how do i set up an empty git repository over http, like i would
over ssh of the fs?
