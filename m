From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Suggestion for mailing lists... split [PATCH]-es into own list
Date: Fri, 12 Oct 2007 17:50:41 +1300
Message-ID: <46a038f90710112150r16b566c6q8f2a58250d803347@mail.gmail.com>
References: <e47324780710110857s472bf099u3e350d17a2c29f78@mail.gmail.com>
	 <Pine.LNX.4.64.0710111704570.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Harning Jr." <harningt@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 12 06:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgCUB-0006NT-3D
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 06:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXJLEuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 00:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbXJLEuo
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 00:50:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:35810 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbXJLEun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 00:50:43 -0400
Received: by ug-out-1314.google.com with SMTP id z38so566426ugc
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 21:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cbONasUgGfDojvQZ51Bpva9CZ7hlliH4m0VnMh+k1JA=;
        b=hzLi3iT1lHyw1DTzrydhOXR4s6u5fZuVulBbwqw0X+RstLaWZ+EXSxlEgGhmrjkBS3GBdRfcceSPLSoHZQFeWVazuqgamudRozzwYKazR4lq4MS1Qyd/rXf9Ky5P/Yi6xND8oecjYj+AdOEJ4UPyWcGiRx3D4/sNPHoE4kCsCPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eXr1vcG/VbEVlzt5i8/W3IBCRrwrbkrf3ty1oRdhAStBYsxVZoUySDNRJboJjo5Xb8oPZhg+Oywyu5FQcDlRlJDqvtrSPzRqSJ1uRGWp2/NkElTZCzCq5BJDx3wapMSxF7z7jQT2ukpDSfOcjH8Dqp7Z6XyzwB9p+IvIlElkmzA=
Received: by 10.66.249.16 with SMTP id w16mr3943835ugh.1192164641176;
        Thu, 11 Oct 2007 21:50:41 -0700 (PDT)
Received: by 10.67.22.19 with HTTP; Thu, 11 Oct 2007 21:50:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710111704570.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60655>

On 10/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I, for one, am totally opposed to this split.  All too often valuable
> _user_ discussions turn into _technical_ discussions, and thence into a
> throwing back and forth patches.

<aol>mee too! - I think it's the kind of development culture that
Linus tries to foster, and I suspect Junio likes too: "talk in
patches" which is a lot more productive than "talk like a pirate",
bikeshedding and other maladies that can fester in mailing lists.

So no split for me ;-) We have the additional alibi that git users are
supposed to be programmers.



m
