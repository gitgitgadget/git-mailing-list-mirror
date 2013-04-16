From: Michael Weiser <M.Weiser@science-computing.de>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Tue, 16 Apr 2013 16:56:54 +0200
Message-ID: <20130416145653.GG12782@science-computing.de>
References: <20121127163004.GC7499@science-computing.de>
 <20130305115837.GD21473@science-computing.de>
 <7vd2vdvn7l.fsf@alter.siamese.dyndns.org>
 <20130306081942.GA11151@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 17:07:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US7TT-00052j-FF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 17:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3DPPHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 11:07:05 -0400
Received: from mx4.science-computing.de ([193.197.16.30]:1639 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3DPPHE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 11:07:04 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2013 11:07:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 8AFF9414009;
	Tue, 16 Apr 2013 16:56:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MtbTco8KSUT; Tue, 16 Apr 2013 16:56:54 +0200 (CEST)
Received: from samoa.science-computing.de (samoa.science-computing.de [10.0.5.93])
	by scmail.science-computing.de (Postfix) with ESMTP id DC206414004;
	Tue, 16 Apr 2013 16:56:54 +0200 (CEST)
Received: by samoa.science-computing.de (Postfix, from userid 1176)
	id CC88C10101; Tue, 16 Apr 2013 16:56:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130306081942.GA11151@science-computing.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221423>

Hello Junio,
Hello list,

On Wed, Mar 06, 2013 at 09:19:42AM +0100, Michael Weiser wrote:

> > >> Support determining the binaries' installation path at runtime even if
> > >> called without any path components (i.e. via search path).
> > The default for any change is not to include it.  Is there any
> > reason why we want this change?
> It makes a binary git installation fully relocatable. Seeing how git
> already has basic support for it I thought other people might be
> interested in this.

I am still interested in getting this accepted into git. Where do I push
to get it committed?

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
