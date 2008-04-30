From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Tracability in git commits
Date: Thu, 1 May 2008 01:33:53 +0800
Message-ID: <46dff0320804301033k1dea34ecx863ecfa8e386e0af@mail.gmail.com>
References: <1209473739.5642.31.camel@dax.rpnet.com>
	 <7vd4o873cm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Richard Purdie" <rpurdie@rpsys.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:34:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrGCa-0007rA-V6
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762782AbYD3Rd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762702AbYD3Rd4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:33:56 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:62200 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762342AbYD3Rdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:33:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so128358and.103
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=L/GynikfzOY8E2+TdfhloISfrOYYL/JnN5Wnyk7/jMI=;
        b=DM69FoXQ2FLs6nhaRHMaW4RlFmuIptJlfT7dpjpWn9x50TLPjtUvWqfr0pTc58cCTFswBKu0JWHcCaf+UVLolYdh7zIhbAlUS2Qtl0vHa2VRp1NHaLVrlhRSft8Vwib3wRtBU9B1p7hJCaTwOBLWeQvIHcWHC8W+FQ9ohfY8NVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mDVpMyLYFYswdIGffyxazX89p1FYRMbHYrKuTIuuaeK5uCAKkjej11Lhrvh4w//NIy4D52vM/sLfDdrAsfEZdQ3diLClIYhcrFrRJNNGr3++Ahb9G5aDyTNuBIJVjDp5NbzbHivJ5yJ+9/qb+I+LQifj8wQxIQMwbxF4IFMu298=
Received: by 10.100.120.6 with SMTP id s6mr1684134anc.72.1209576833377;
        Wed, 30 Apr 2008 10:33:53 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 30 Apr 2008 10:33:53 -0700 (PDT)
In-Reply-To: <7vd4o873cm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80857>

On Wed, Apr 30, 2008 at 5:34 AM, Junio C Hamano <gitster@pobox.com> wrote:


>  is updated, using that added part of the history.  The updates to the tip
>  will be recorded in reflog to record who updated the tip and when, which
>  would allow you to go back and point your finger at the person who
>  introduced problematic new history

I don't find reflog for bare repository, or must i enable it manually?



-- 
Ping Yin
