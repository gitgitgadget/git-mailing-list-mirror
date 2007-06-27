From: Steven Grimm <koreth@midwinter.com>
Subject: Re: post-update script to update wc - version 2
Date: Wed, 27 Jun 2007 00:54:28 -0700
Message-ID: <468217B4.3030708@midwinter.com>
References: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Vilain <samv@utsl.gen.nz>
X-From: git-owner@vger.kernel.org Wed Jun 27 09:54:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3SMW-0000LQ-So
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 09:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401AbXF0Hyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 03:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757324AbXF0Hyb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 03:54:31 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:50201
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1757215AbXF0Hyb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 03:54:31 -0400
Received: (qmail 19042 invoked from network); 27 Jun 2007 07:54:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=k/PyeXYNBa82ejHCcCZph2XSYncgLIJi4YKvdDZgHzETxKDnLTZKviCdHoavtRwY  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 27 Jun 2007 07:54:30 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51024>

Sam Vilain wrote:
> # An example hook script to prepare a packed repository for use over
> # dumb transports.
>   
Maybe this comment isn't quite accurate any more?

-Steve
