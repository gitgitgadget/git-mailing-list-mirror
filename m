From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 15:36:38 +0000
Message-ID: <200702271536.39864.andyparkins@gmail.com>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 16:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4Nl-0002ri-T0
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbXB0Pgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbXB0Pgr
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:36:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:38138 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167AbXB0Pgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:36:46 -0500
Received: by nf-out-0910.google.com with SMTP id o25so217834nfa
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 07:36:44 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YxnbLGJPkZHktRDkOBdzX4RJzAP1O2Eq2PmRaiTp9zVY+O0bN6Fpmg8L0A47DljPnZj9D7rJzC0AoegcoGh4c//tu75QNDI9KLGSYfKh6nYVXHIRcahzzrKw3G6YZMEDQQG/yYvdXDyU+wRe3c9y9iUVUPQk7a844lSSSULrnpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EAPQ6ibcF6c6xs7fpcOL+cvdoiYSGzJ9MXEhxbeA5qwV0dT2fQERuCVy796e8zeIR2hiF/GxASyhek5RL5p2O5ozjRkaz5Qp6II2Jqy0VJ8bZ16FPlx5TtYqGsNMoUlC7SCt2t3RC2qHXaFopk1htdsJJJSi93LMmclMUv67vgE=
Received: by 10.49.29.2 with SMTP id g2mr1365265nfj.1172590604806;
        Tue, 27 Feb 2007 07:36:44 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id l21sm2237104nfc.2007.02.27.07.36.41;
        Tue, 27 Feb 2007 07:36:41 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40748>

On Tuesday 2007 February 27 12:31, Junio C Hamano wrote:

> Which is kind of depressing...

Maybe not.  It's my feeling that the traffic on the git list has taken a 
significant jump lately.  There have been a lot of new users asking 
questions.

Could it be that more users equals more bug reports?  Could it also be that 
new users tend to use git (let's put this politely) "outside of the box".

The users popping up on the list will be a small percentage of actually 
using/adopting git.  I think it's great, not depressing.  I'm a relatively 
new user of git, and just in the time I've been lurking the bugs/issues that 
affect me have dropped significantly.

As the philosopher says: don't worry, be happy. :-)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
