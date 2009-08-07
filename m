From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH 1/5] revision caching documentation: man page and technical
   discussion
Date: Fri, 07 Aug 2009 14:07:14 +0200
Message-ID: <4A7C18F2.2000905@dawes.za.net>
References: <op.ux8i6lq9tdk399@sirnot.private> <4A7B9ACA.1060601@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Nick Edelen <sirnot@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Aug 07 14:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZOFp-0003dz-9x
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 14:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076AbZHGMIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 08:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755985AbZHGMIe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 08:08:34 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:43960 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbZHGMId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 08:08:33 -0400
Received: from homiemail-a6.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id AE18317AF23
	for <git@vger.kernel.org>; Fri,  7 Aug 2009 05:08:34 -0700 (PDT)
Received: from artemis.local (dsl-246-25-180.telkomadsl.co.za [41.246.25.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTP id CD0D9153CF;
	Fri,  7 Aug 2009 05:07:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4A7B9ACA.1060601@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125192>

Sam Vilain wrote:

>> +`fuse`::
>> +	Coagulate several cache slices into a single large slice.
>>   
> 
> Coagulate?  You mean, the revision caches will stop being liquid and go
> gluggy, like a pool of blood clotting?
> 
> How about "combine" :-) - and the option might be better called
> something simple like that, too.

I think the word he had in mind was "coalesce".

Rogan
