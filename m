From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: RFC re Thunderbird + imap-send
Date: Tue, 10 Feb 2009 13:24:40 +0100
Organization: Beonex
Message-ID: <49917208.6000807@beonex.com>
References: <4990A4FF.6020404@codeweavers.com> <49915FB6.8010803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeremy White <jwhite@codeweavers.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrhR-00008s-AV
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZBJMZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbZBJMZW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:25:22 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:52608 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbZBJMZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:25:22 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id C3001303C560;
	Tue, 10 Feb 2009 13:25:32 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <49915FB6.8010803@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109223>

On 10.02.2009 12:06, Michael J Gruber wrote:
> For a typical text mail in Drafts I see lines like
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: quoted-printable
> Any chance we could use that rather than invoke the HTML editor?
> We would need to shut off q-p and f-f *and* avoid automatic word wrap
> (or make sure patches don't have longer lines then TBs editor allows),
> the latter I don't know how to do.
>    
I'm not aware that existing headers would influence the send logic (in 
turning on/off qp or f=f or word wrap).
