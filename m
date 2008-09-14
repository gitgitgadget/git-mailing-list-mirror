From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Sun, 14 Sep 2008 17:45:06 +0700
Message-ID: <fcaeb9bf0809140345n11d41430ma9b4096c66776b0c@mail.gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
	 <200809112214.18366.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 12:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kep7a-00025L-1B
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 12:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYINKpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 06:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbYINKpM
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 06:45:12 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:42645 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYINKpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 06:45:10 -0400
Received: by ey-out-2122.google.com with SMTP id 6so697902eyi.37
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qrI71qhF6EHDCN97O2L9NkHgKErXPtX8BOrvKoozI/c=;
        b=L3V0dBAo0ZAKUwULE0gVezeDirXx9YmdSO78v7LtC24/jsUUK/ZljmoB6+D+LhrAcY
         fl0GsSf5r7pjHgvx+YDntrFh+wOQflH9Y4wIbqm4UxoZrI9abHEmTlkkpDj1lgdQZk0b
         XpTWdM6flWoxqME9suzWzGMShYMr2kAoJ9fGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ocpzc5esYLgLPArNBr/aFvdohqktSRvrLBTlCy57RXk+KbHeK13usEUHyGp0PzJYt3
         1yFRIMjgzHG/6hOdrc1epxpxxCw7Yj4vKgn0FQ8X66Ykzb3+rkeDwWDKgyxJUJR+imP5
         tPIKzLX6xULjWL9WR9o9YG/cjbgke0skDPYCc=
Received: by 10.86.63.19 with SMTP id l19mr4847205fga.77.1221389106942;
        Sun, 14 Sep 2008 03:45:06 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Sun, 14 Sep 2008 03:45:06 -0700 (PDT)
In-Reply-To: <200809112214.18366.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95826>

On 9/12/08, Jakub Narebski <jnareb@gmail.com> wrote:
>  15) Do you miss features in git that you know from other SCMs?
>     If yes, what features are these (and from which SCM)?
>     (Open ended text - Essay)
>
>  Total respondents       1046 (some/many of them wrote 'no')
>  skipped this question   1249
>
>  This is just a very quick summary, based on a first few pages of
>  responses, Full analysis is I think best left for after closing the
>  survey, because I think this would be a lot of work...
>
>  So here is preliminary list, or rather beginning of one:
>   * sparse/partial checkout and clone (e.g. Perforce)

Have not read the survey result, but do you recall what is the most
used term for sparse/partial checkout? What SCMs do sparse/partial
checkout? I think it could be usable as it is now in my
will-be-sent-again series, but I don't really know how people want it
to from that.
-- 
Duy
