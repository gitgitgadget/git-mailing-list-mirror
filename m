From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Introduce diff_filespec_is_binary()
Date: Fri, 6 Jul 2007 13:20:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061320180.4093@racer.site>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
 <7vejjnhpap.fsf@assigned-by-dhcp.cox.net> <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
 <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051223520.9789@racer.site>
 <7vejjmexm0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:28:10 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6muv-0006wD-H3
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759695AbXGFM14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759631AbXGFM1z
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:27:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:60444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758747AbXGFM1z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:27:55 -0400
Received: (qmail invoked by alias); 06 Jul 2007 12:27:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 06 Jul 2007 14:27:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WvfljfHBWfWosXseKPx/9//9+TG2pwxi7lcKpx1
	IMTa+8T+MOsWUa
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejjmexm0.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51745>

Hi,

On Fri, 6 Jul 2007, Junio C Hamano wrote:

>  Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>  > It is quite cute to hide this in the funcname patch...
> 
>  So this is the proper refactoring _before_ any of your topics.

Thanks. And sorry for bugging you.

Ciao,
Dscho
