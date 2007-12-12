From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 16:11:30 -0800 (PST)
Message-ID: <m363z4srf3.fsf@roke.D-201>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: David <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2FCg-0004cC-SN
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 01:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXLLALh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 19:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXLLALg
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 19:11:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:64207 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbXLLALf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 19:11:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so14505nfb.21
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 16:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=NlyiPU43E0W/BBRAzrhN+GiDofjB0V6pUIPzLOM52oo=;
        b=Vilk4IdHWZEUzV7I1AvhipcXo3PaH8FIKWM5uj0EXygv6ghmPaUlg69zxKyS6dkt1pgVoipIvuAX1wv+4ZmQ3iIfa7uHHT6/v/dyIAVVYBivkq5bKYNwuKcR9IyBGVmV37JvUisP/pAbhXK6PHRPwQzeMGKD09sEHVsr2m8pB9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=hi3+dl05SF1eBKc0oVNyHFS7UI5F4LSeOJns3R+fLgiDKy22Qy8gOrWSYMQ1JDR57cCV+t1pG7sx9Ir9Baqma+gnAuQJKrYqrlJuDHpN0jU8fBzRVcRzegZkP55FLc+LW+V4M88NhuYJy6ZIstJZAg/8FDvL+Ujleh3i7yFeYVw=
Received: by 10.86.61.13 with SMTP id j13mr34179fga.9.1197418291193;
        Tue, 11 Dec 2007 16:11:31 -0800 (PST)
Received: from roke.D-201 ( [83.8.252.236])
        by mx.google.com with ESMTPS id l12sm1716435fgb.2007.12.11.16.11.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 16:11:30 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBC0BTuK017254;
	Wed, 12 Dec 2007 01:11:30 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBC0BTM1017251;
	Wed, 12 Dec 2007 01:11:29 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67973>

David <davvid@gmail.com> writes:

> For whatever it's worth, I've written a PyQt4-based git gui.  For lack
> of a better name I call it ugit, as in "I git, you git, we all git
> with ugit" (or something silly like that).

I have added it to http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

Funny that both (h)gct and Qct, which are commit tools too (although
multi-SCM) are also written in PyQt...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
