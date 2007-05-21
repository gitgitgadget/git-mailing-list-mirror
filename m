From: "Stian Haklev" <shaklev@gmail.com>
Subject: just fetching HEAD of repository
Date: Mon, 21 May 2007 16:01:00 +0700
Message-ID: <566574ef0705210201wc5c0adbmaa22d197b16bf72d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 11:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq3lZ-0006du-7g
	for gcvg-git@gmane.org; Mon, 21 May 2007 11:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757024AbXEUJBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 05:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757092AbXEUJBB
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 05:01:01 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:41465 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934AbXEUJBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 05:01:00 -0400
Received: by py-out-1112.google.com with SMTP id a73so262328pye
        for <git@vger.kernel.org>; Mon, 21 May 2007 02:01:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P6tbcQnPSq0DGosfE/Ts/AefTmXl5KpN1mfyBsMkHQ69FL/HmExP/TwdETdPSnVr/bEL2n9Z0Y7efv47buU7KWprMtVN5zzGSizhOpV+kWi2RtXSzFQu47eZ7bukeih1Vf0ilwlzYbMjHC8Mp6vP7QQgKZkhOjRg+bRiEA/Flow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HyJhY9mTE4RNpEQ6dVH8yRfdWdYjWxbMaJkBwLQhhLxvjgTu+s3qIC9SgCfpNkjMaWnCqleZB6CDIA2KDOAoZUwCNCGpbUAGUl0XBPfwPEvp5/54yaMLgwrylRUxq8ABhWKon3JD02HtRac8tkiLvz/pd4kIDI8fdn/JZGL3VIw=
Received: by 10.35.93.15 with SMTP id v15mr8403651pyl.1179738060146;
        Mon, 21 May 2007 02:01:00 -0700 (PDT)
Received: by 10.35.72.14 with HTTP; Mon, 21 May 2007 02:01:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47997>

After checking all the docs, I am still wondering if there is a way to
get only the last commit from a given git repository. Sometimes I
really just want the latest code so I can compile it - and let's say
they are not running gitweb, or it is not convenient to go to gitweb
and ask for a tar package to be made? This is especially relevant in
countries with slow internet connection - here in Indonesia it takes
me an hour to clone the git repository for example, never mind let's
say the Linux kernel.

Thank you
Stian
