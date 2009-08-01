From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 23:39:24 +0200
Message-ID: <40aa078e0908011439q78a4cdefqa0b05955cc6a5fde@mail.gmail.com>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	 <m3r5vy1siq.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302>
	 <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
	 <alpine.DEB.1.00.0908011431060.8306@pacific.mpi-cbg.de>
	 <94a0d4530908010610n31261414yc08060f3de9c115f@mail.gmail.com>
	 <40aa078e0908010704k7581b656h1ed98a8852efa445@mail.gmail.com>
	 <CC0DDAD1-D61F-465F-9533-95A101C61522@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sat Aug 01 23:39:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXMIi-0004Pq-MK
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 23:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZHAVj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 17:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbZHAVj2
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 17:39:28 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64661 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbZHAVj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 17:39:27 -0400
Received: by fxm17 with SMTP id 17so1973048fxm.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c1VohKQk//wICYl5+7/qFCw1sFKuKtaXHgrWqVJ9KFE=;
        b=mjkQJ98sTGbXHlj6wuoBFta5UxbaWU1Y3UOheJgmW9bUm5yUs71wCZMf5ryjKxmX66
         Z/udkmTS6zYsIxx66OFjSCJQV/jMvJFQQ/eZsdImgHrBQTNdyG6HdAZa/RBUX49PzOdu
         b7+tqeUWtUgfmNMJDUohDQRvDEX6YIDkueIdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KMVVI6HlioDeZweQI0zltlIaEuZoPm80S63gF357cic/AzUKBB/LmGh8Ofhs3BI01+
         exe4thyQSvtggyAflFzdq24Y7x+GterWsg1LQ6zEO3A/bjMS92yBJrqetGjCjq+dz0c0
         LHzZJ91QyzJ4mZ6pJVDE6adUQVG2GK9rtUeG8=
Received: by 10.204.101.80 with SMTP id b16mr5156341bko.73.1249162764321; Sat, 
	01 Aug 2009 14:39:24 -0700 (PDT)
In-Reply-To: <CC0DDAD1-D61F-465F-9533-95A101C61522@uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124648>

On Sat, Aug 1, 2009 at 6:07 PM, Mark A Rada<marada@uwaterloo.ca> wrote:
> FWIW, Windows doesn't seem to come with a whole lot, and you need
> 3rd party software for a number of things

Tell that to the US Department of Justice ;)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
