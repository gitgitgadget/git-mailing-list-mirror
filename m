From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Question about git-svn import
Date: Wed, 19 Dec 2007 12:29:27 +0100
Organization: Home - http://www.obry.net
Message-ID: <47690097.6070603@obry.net>
References: <4766AF65.5060706@obry.net> <20071218034836.GA27080@dervierte> <4767724A.9040207@obry.net> <20071218153159.GA12549@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4x7d-0006zh-9p
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbXLSL3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbXLSL3d
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:29:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:2865 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbXLSL3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:29:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so478761fga.17
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 03:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=auDOVN/McLsNszf0iROvOGyXuyKivjCSDrLbozipBCg=;
        b=IvJhwfav3X4KRh83mf/9RZI9+LcVktagCmjTpV/QZyvAMMbNbGjOcCvBUGlQD7IRt7y0WFEBMKojEbfA1IzzDXpWmyFGtNQc5XkhFG53WOHB3vJG/sb4OvrBShFxFULtfI+TeBzTl9uRGj30nmUXs5U2n+RycwDMSwMBMW8N2rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=CwitTrccKnsyCfOlxUzio7gbfww09MPFOdf/xfYGXMN1X1lv2oGj0OQVR78dTX3nbVQA3LQbiW/8wfzKkw5FeyKfnJKBG7D/XLjU5UezwydYhfXfAlFMz5ueblOmxrf/lSBPH8IzVvFt8aGNbZm3vqR0GVrNjY0XGp9kFDrXNSk=
Received: by 10.86.36.11 with SMTP id j11mr8787167fgj.34.1198063770667;
        Wed, 19 Dec 2007 03:29:30 -0800 (PST)
Received: from ?10.10.127.189? ( [212.99.106.127])
        by mx.google.com with ESMTPS id 3sm6565769fge.2007.12.19.03.29.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Dec 2007 03:29:29 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071218153159.GA12549@alea.gnuu.de>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68887>

J=F6rg,

> It's not as complicated as you might think.

Ok, thanks for the pointers. I'll have a look.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
