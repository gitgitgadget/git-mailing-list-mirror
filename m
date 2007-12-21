From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: cvs -> git tools?
Date: Fri, 21 Dec 2007 21:46:16 +0100
Organization: Home - http://www.obry.net
Message-ID: <476C2618.4090500@obry.net>
References: <476C1D9E.4060700@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Fri Dec 21 21:46:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5olc-0001WL-4P
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 21:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbXLUUqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 15:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbXLUUqZ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 15:46:25 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:58556 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbXLUUqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 15:46:24 -0500
Received: by fg-out-1718.google.com with SMTP id e21so223930fga.17
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=4DPKykJFFuq7Mwelk9Ik+Y65fjYGkl3nmsGtg9BUJhU=;
        b=J7vdQcDlNfxuTgmmguubaXvs4TUj8CRSYNkz+UST8Tbu4CCWoy5/80JU1zHoe9x3fPVQwXbrPeKJAYy4PPlcWnQvambziWW87YlK/+iUM38APo8Fu0zACIb4dTg9Seq6IOLwrkgZsN5AZgR3f6yTSFy6Re7q0L32/KiAzPs1Df0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=sYAjBW50f7xbAzS5XFMJbGl+ZnndEVfmK2c2zYJ5bME2XC2SNI7BEjb7PdVCKL5pjJVy+1X8TVy+2LF9IPSRvlnmaOiS8czKKfrS2rPV/pIqlQ29GyiURGzZmeQMrQAYtOoe7kTtICRt6oQ7+gdWLIEAnkYcBnFKHqomxHB0yrw=
Received: by 10.86.54.3 with SMTP id c3mr1509729fga.4.1198269982170;
        Fri, 21 Dec 2007 12:46:22 -0800 (PST)
Received: from ?192.168.0.100? ( [81.249.63.6])
        by mx.google.com with ESMTPS id 3sm1547914fge.7.2007.12.21.12.46.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Dec 2007 12:46:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <476C1D9E.4060700@advancedsl.com.ar>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69091>

Gonzalo,

> I was wondering if there were any tools to keep a mirror repository of
> CVS as a git repository.

I'm no expert on this, maybe cvsimport. I'll let other answer.

http://www.kernel.org/pub/software/scm/git/docs/git-cvsimport.html

> As a second question...
> 
> Are there any good websites that can host a git repository?  Something
> equivalent to sourceforge but for git.

Savannah support Git.

There is also http://repo.or.cz

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
