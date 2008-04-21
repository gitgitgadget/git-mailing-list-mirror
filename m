From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: git branch diagram
Date: Mon, 21 Apr 2008 08:48:46 -0400
Message-ID: <1c5969370804210548q4b6aa30h8a8c0323b3fc51d4@mail.gmail.com>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
	 <m3fxtgqcbr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Patrick.Higgins@cexp.com, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 14:49:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnvSq-0002DI-J9
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 14:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbYDUMsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 08:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756688AbYDUMsv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 08:48:51 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:57574 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830AbYDUMsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 08:48:51 -0400
Received: by rn-out-0910.google.com with SMTP id e11so293544rng.17
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zXE/KBI4okX2Xvv4Tkj1gX4W8zIZvzFbW/wRWlWc04c=;
        b=p/QM380ZjxVl7B/EOB1Yq0NLFQzY/owVEVYg3kqD+h9qMb3pH0wgyWMb7RIJzj632F3ddYyS6KKFqbcSJhunoRBr56A5jW5Qx9k40j05O7KUpGIqla1UbX14Z6cXPc4URZH9ZDwuK1fAYX3H5XO7xIHOpkjlMcessZYrNcQjhuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qOBQtT9c9XNu23vTqhd/up2RBAPkkVAA3Nh9vMouTzSwmJHmEoTeqjLg2lSDT9fiNO52/ThVRZ1XX6uZs7Hh9aQAcqpsIhW7+r6Pu2yi9yEDxAMONQyQLBwc0WOAtpZtpNlnnwDni40eUxiquR9xPHngazlBjlbPre6XKCwieWY=
Received: by 10.143.10.15 with SMTP id n15mr1676310wfi.307.1208782126627;
        Mon, 21 Apr 2008 05:48:46 -0700 (PDT)
Received: by 10.142.179.14 with HTTP; Mon, 21 Apr 2008 05:48:46 -0700 (PDT)
In-Reply-To: <m3fxtgqcbr.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80022>

On Sun, Apr 20, 2008 at 8:30 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> <Patrick.Higgins@cexp.com> writes:
>
>  > In my diagram, I am assuming that most developers work in master,
>  > and make branches for their own long-lived projects and experimental
>  > things.
>
>  For example git itself, as a project, uses three long-lived branches:
>  'maint', 'master' and 'next', uses 'pu' (proposed updates) branch as
>  propagation / review mechanism for short-lived tipic branches.

Jakub, could you explain the difference between maint and master?  And
the difference between master and next?  Maint and next are clear, but
how does master relate to those 2?
