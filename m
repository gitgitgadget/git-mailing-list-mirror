From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: What's cooking in git.git (Apr 2010, #01; Fri, 02)
Date: Sat, 03 Apr 2010 00:58:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004030055110.694@xanadu.home>
References: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 06:58:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxvRJ-0003FK-8D
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 06:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab0DCE6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 00:58:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51587 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0DCE6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 00:58:15 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0A00977B52WM80@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Apr 2010 00:58:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143879>

On Fri, 2 Apr 2010, Junio C Hamano wrote:

> * np/malloc-threading (2010-03-24) 1 commit
>  - Make xmalloc and xrealloc thread-safe
> 
> Still has locking issues?

Indeed.


Nicolas
