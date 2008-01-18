From: Nicolas Pitre <nico@cam.org>
Subject: Re: fast-import.c: zlib_compression_level vs pack_compression_level
Date: Fri, 18 Jan 2008 10:44:02 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801181043100.25841@xanadu.home>
References: <e5bfff550801180504v17df7976x59d12f210efe583e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFtOX-0001vp-Nv
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 16:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYARPoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 10:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759455AbYARPoG
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 10:44:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15655 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759386AbYARPoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 10:44:05 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUU00GPIJPELW80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Jan 2008 10:44:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e5bfff550801180504v17df7976x59d12f210efe583e@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71029>

On Fri, 18 Jan 2008, Marco Costalba wrote:

> My question is, does fast-import should use pack.compression instead
> of core.loosecompression?

Yes it should.


Nicolas
