From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] Make 'cvs ci' lockless in git-cvsserver by using
 git-update-ref
Date: Tue, 27 Feb 2007 09:35:25 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702270933060.29426@xanadu.home>
References: <200702210908.59579.andyparkins@gmail.com>
 <200702271248.59652.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 15:35:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM3QR-0002Cc-PT
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 15:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbXB0Of1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 09:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbXB0Of1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 09:35:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19595 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbXB0Of0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 09:35:26 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE4002S0LV114Y1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 09:35:25 -0500 (EST)
In-reply-to: <200702271248.59652.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40739>

On Tue, 27 Feb 2007, Andy Parkins wrote:

> This patch is actually yours (with one extra removal of lock file reference
> that you'd missed, and a change of shortlog), but I don't know how to send
> an email that comes from me but attributes authorship to you.

Start your email body with a "From: " and the address of the person.


Nicolas
