From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 02 Aug 2007 19:35:30 +0200
Message-ID: <46B215E2.8010307@fs.ei.tum.de>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 19:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGeaK-0005YS-GO
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 19:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbXHBRff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 13:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758132AbXHBRff
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 13:35:35 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:40743 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbXHBRfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 13:35:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 49666280E3;
	Thu,  2 Aug 2007 19:35:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SxjGv5z9U8+2; Thu,  2 Aug 2007 19:35:30 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 05B50280DE;
	Thu,  2 Aug 2007 19:35:30 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54576>

Steffen Prohaska wrote:
>   fromcvs's togit surrendered during the import.
>   fromcvs's tohg accepted more of the history, but finally
>     surrendered as well.

Which repo is it you are converting?  Is this available somewhere?

I'd appreciate any reports concerning "surrenders" of fromcvs.  Additionally, it seems strange that tohg should have worked "better" than togit, as these are basically just different backends.

cheers
  simon
