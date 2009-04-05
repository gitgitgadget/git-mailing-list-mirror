From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: non-ascii filenames issue
Date: Sun, 5 Apr 2009 16:22:23 -0400
Message-ID: <76718490904051322u48f22143s6744d62a37fa55ec@mail.gmail.com>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>
	 <20090405100127.GA12126@home>
	 <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
	 <76718490904050923j105e383dsf650afa0a0687858@mail.gmail.com>
	 <7vfxgmrjb7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>, Teemu Likonen <tlikonen@iki.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYsn-0000pS-Kp
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbZDEUW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbZDEUW0
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:22:26 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:32816 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZDEUWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:22:25 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1843143ywb.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EKRZIrHGFWicpvDldL2VJf0clGppxguJt/3nL6bZfns=;
        b=gz4+x1XwxIpOxo5ZNUkJFuEyMu1sOUP54p9W29ENFf+RAuzdwxaujU9Z9WQ3+vJxzV
         HhMj+QcmXmI4H3X23EA3uGhewumhGciB38vpcxjitfimTQ4QwZfjW5QFvRr5cFn9mEaU
         jGcP76L13V0hj5wZNAh00I97d/kf51BmcELrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FmZM6KGrBpb1swS38vQqUxC/UjiVEAkj6J5G21RSG5MMk7+raSUrXCHBmt8g0rkO1t
         16JXD04k3zh9BsDLP4oZNjML3dNMMHwUa7C0Ks7G9yOSlu/Ro3LF4yad2Y+eU9xLeq8G
         Yq1PnTuMyD9IGreeXpSLIo02pgeVTxgx+p70g=
Received: by 10.150.54.6 with SMTP id c6mr222672yba.10.1238962943086; Sun, 05 
	Apr 2009 13:22:23 -0700 (PDT)
In-Reply-To: <7vfxgmrjb7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115697>

> I do not think the message gives enough information on the issue

Of course you are correct. I was perturbed by John's message, but your
thoughtful reply is much more beneficial than my silly link. Thank you
for providing the level-headed response as always.

j.
