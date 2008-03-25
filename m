From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Auto detaching head options (Re: Working copy revision and push
 pain)
Date: Tue, 25 Mar 2008 20:58:40 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803252056400.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.LSU.1.00.0803231401340.4353@racer.site> <47E658D3.1060104@jwatt.org> <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com> <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
 <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org> <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org> <alpine.LSU.1.00.0803231658460.4353@racer.site> <20080325192552.GC4857@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Watt <jwatt@jwatt.org>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:59:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeFIs-0007Tl-L1
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbYCYT6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYCYT6p
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:58:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:59289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751964AbYCYT6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:58:44 -0400
Received: (qmail invoked by alias); 25 Mar 2008 19:58:42 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp018) with SMTP; 25 Mar 2008 20:58:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aEYJ8eR1aibHOlwWXBjkWzgJF1tSI7D2YxrUTfe
	p4nNsjYLhwXiI2
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080325192552.GC4857@efreet.light.src>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78216>

Hi,

On Tue, 25 Mar 2008, Jan Hudec wrote:

> The proponents of this (and I also) think, that meaning of HEAD is, or 
> rather should be, "the revision your work tree is derived from".

By far the most operation I do with HEAD is to _advance_ it.  So for me, 
HEAD must be a pointer to the ref which is to be advanced.

I don't care about detaching the HEAD when pushing into the current 
branch, which you are not supposed to do anyway.  Really.  I could not 
care less about that.

You can do it -- I already pointed out that you can do that with hooks -- 
but please do not bother me with it.

Hth,
Dscho
