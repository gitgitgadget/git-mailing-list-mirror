From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 13:40:33 +0200
Message-ID: <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 13:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl1a8-0003wS-3X
	for gcvg-git@gmane.org; Mon, 07 May 2007 13:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbXEGLkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 07:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933161AbXEGLkg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 07:40:36 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:32694 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbXEGLkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 07:40:35 -0400
Received: by an-out-0708.google.com with SMTP id d18so133079and
        for <git@vger.kernel.org>; Mon, 07 May 2007 04:40:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kf/KaJYSpIblaxbs3/TULtD8CQ60hcvYSRK5kuuLnj5ykc9anPo4pH7t3v6bJmY7jRyUuSKNkizTUCG8mjPA3HQP7TabfQ9u1hFu3PgrVr2UPRSJqE5CZZShKSBbyxOgERcyZaanHdFVBUalgJx+QfWAUHlZUeb8fVz/A2KXTc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dPtLdu6JOyLK4lO7kgYqMu5QKrv25q9MOPmp7THhf8mssW1m5p97LVC4bkqngyPxnDzAsgmynX7mwSP3LYqJ7Y0yBRAvXmqbFEaxb2j1DDPkPkM68Dbfcbx8lRUxWb+JdpM6kOOxxoT2DOqHM7nx9Rt6ZH/EVCbPps83AcsF9Vg=
Received: by 10.100.165.9 with SMTP id n9mr4681917ane.1178538033566;
        Mon, 07 May 2007 04:40:33 -0700 (PDT)
Received: by 10.100.46.11 with HTTP; Mon, 7 May 2007 04:40:33 -0700 (PDT)
In-Reply-To: <vpqwszm9bm9.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46450>

Hi,

As a newbie, I'm agree with Matthieu: the Git's index is surprising
for people coming from CVS/SVN (mindless?) world. So a good
documentation about this, even in tutorials, is really important.

In order to improve my productivity with Git, and in order to avoid
traps around moving from SVN to Git, I often use the Git Emacs mode.
It is really usefull for beginners as it works similarly for CVS, SVN
and Git: synthetic view of all modifications, easy selection of what
will be commited... The biggest drawback of this "porcelain": using
it, you do not understand the Git's index philosophy.

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
