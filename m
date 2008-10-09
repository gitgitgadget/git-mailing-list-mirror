From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Fwd: git status options feature suggestion
Date: Thu, 9 Oct 2008 02:27:49 -0400
Message-ID: <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
	 <20081009061136.GA24288@coredump.intra.peff.net>
	 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 08:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knp1P-0000Iy-70
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 08:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbYJIG1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 02:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbYJIG1z
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 02:27:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:5193 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbYJIG1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 02:27:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4651212rvb.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 23:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=60mX6NeqNYDQ6+vCGGtt1XJMkQGqErz42o6obqcGQ2Y=;
        b=T6AUyrKUUBh+Aik0mzYRmFHDDliZnGwV7sGUNWrjdtcJP4EkpGNmPeKrj7W5EWa2VO
         EB2hyJqHkS4H0X9SOE8M90ugbAHK+JMVJApArt0ojx6Gh4Vwxd82ZmKawgQ0AbfOHIPU
         D9aShokj+/Z2JOuwlAySdQmBEHQY3EhPhcJpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jMfG6aIXsX6ihS9XdD8KEalCIlzwax43hASnhok0MTv96tbTL8+vzDO8kpW7qiroSX
         JO/M72yLW5tfT+HnrCqyE29aW/jGZ1IOZiSECTqDiPy/hgXHhFwXrdsf75QgL0W5oa7o
         zkrHI/ZzBMtFDbp0AJRQZ7rJq6ZJaMPeza9yE=
Received: by 10.140.185.1 with SMTP id i1mr5800498rvf.264.1223533669078;
        Wed, 08 Oct 2008 23:27:49 -0700 (PDT)
Received: by 10.141.145.7 with HTTP; Wed, 8 Oct 2008 23:27:49 -0700 (PDT)
In-Reply-To: <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97830>

> How about "git ls-files -o"?

doh... hadn't even heard of that command.

-- 
Caleb Cushing
