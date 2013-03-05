From: Michael Weiser <M.Weiser@science-computing.de>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Tue, 5 Mar 2013 12:58:38 +0100
Message-ID: <20130305115837.GD21473@science-computing.de>
References: <20121127163004.GC7499@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 13:09:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCqgM-0005IX-5X
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 13:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab3CEMI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 07:08:56 -0500
Received: from mx4.science-computing.de ([193.197.16.30]:65287 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3CEMIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 07:08:55 -0500
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2013 07:08:54 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 14022AC03E;
	Tue,  5 Mar 2013 12:58:39 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n0IhTx3LP3Bd; Tue,  5 Mar 2013 12:58:38 +0100 (CET)
Received: from verus.science-computing.de (verus.science-computing.de [10.160.1.22])
	by scmail.science-computing.de (Postfix) with ESMTP id 69644AC037;
	Tue,  5 Mar 2013 12:58:38 +0100 (CET)
Received: by verus.science-computing.de (Postfix, from userid 1176)
	id 454581044B5; Tue,  5 Mar 2013 12:58:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121127163004.GC7499@science-computing.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217446>

Hello,

On Tue, Nov 27, 2012 at 05:30:04PM +0100, Michael Weiser wrote:

> Support determining the binaries' installation path at runtime even if
> called without any path components (i.e. via search path). Implement
> fallback to compiled-in prefix if determination fails or is impossible.

I see this hasn't made it into git, yet. Is there any reason? What can
I do to get it included?

Thanks,
-- 
Michael Weiser                science + computing ag
Senior Systems Engineer       Geschaeftsstelle Duesseldorf
                              Martinstrasse 47-55, Haus A
phone: +49 211 302 708 32     D-40223 Duesseldorf
fax:   +49 211 302 708 50     www.science-computing.de
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Michael Heinrichs, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
