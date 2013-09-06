From: Dave Williams <dave@opensourcesolutions.co.uk>
Subject: Re: [PATCH V3] check-ignore: Add option to ignore index contents
Date: Fri, 6 Sep 2013 06:59:55 +0100
Message-ID: <20130906055955.GA12622@opensourcesolutions.co.uk>
References: <20130905160801.GA22710@opensourcesolutions.co.uk>
 <xmqqbo46hpk7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 08:00:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHp5Y-0006pN-56
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 08:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab3IFGAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 02:00:05 -0400
Received: from 46-65-59-139.zone16.bethere.co.uk ([46.65.59.139]:62550 "EHLO
	loganberry.opensourcesolutions.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751038Ab3IFGAE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 02:00:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by loganberry.opensourcesolutions.co.uk (Postfix) with ESMTP id 12360EEC189;
	Fri,  6 Sep 2013 07:00:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at loganberry.opensourcesolutions.co.uk
Received: from loganberry.opensourcesolutions.co.uk ([127.0.0.1])
	by localhost (loganberry.opensourcesolutions.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vufl+xpJXs7v; Fri,  6 Sep 2013 06:59:55 +0100 (BST)
Received: from tangerine (tangerine.opensourcesolutions.co.uk [192.168.149.59])
	by loganberry.opensourcesolutions.co.uk (Postfix) with ESMTP id A7D78EEC0C4;
	Fri,  6 Sep 2013 06:59:55 +0100 (BST)
Received: by tangerine (Postfix, from userid 1000)
	id 8A7C4100449; Fri,  6 Sep 2013 06:59:55 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqbo46hpk7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234027>

On 15:27, Thu 05 Sep 13, Junio C Hamano wrote:
> Now the long option name is "--no-index", it makes me wonder if "-i"
> is a good synonym for it, and the longer I stare at it, the more
> certain I become convinced that it is a bad choice.
> 
I had originally called it "--ignore-index" at which point "-i" made
more sense!

Dave
