From: Jason Merrill <jason@redhat.com>
Subject: Re: How to fork on repo.or.cz?
Date: Thu, 06 May 2010 00:38:11 -0400
Message-ID: <4BE247B3.8060704@redhat.com>
References: <x2r86ecb3c71004241233h97e3cf08l89aa4e6ef2fc4425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Thu May 06 06:38:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9sqq-0007hE-To
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 06:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548Ab0EFEiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 00:38:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab0EFEiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 00:38:14 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o464cCLa006996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 6 May 2010 00:38:12 -0400
Received: from [IPv6:::1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o464cB3H023355;
	Thu, 6 May 2010 00:38:11 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100505 Lightning/1.0b1 Shredder/3.0.5pre
In-Reply-To: <x2r86ecb3c71004241233h97e3cf08l89aa4e6ef2fc4425@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146434>

On 04/24/2010 03:33 PM, Dmitrijs Ledkovs wrote:
> Looking at this output it doesn't seem like my fork
> is reusing objects from the "fork parent" repo.
>
> What wrong? How am I suppose to use forks on repo.or.cz such that I
> upload just *my* commits and don't re-upload whole history again.

I have been having the same problem.  I sent mail to admin@repo.or.cz 
about it and got this reply:

>   Thank you for the info. Unfortunately the server admin team is
> currently severely undermanned and there is noone to fix this (anyone
> interested in helping out would be gladly welcome), so all I could do
> for now is to add this to our TODO list.

Jason
