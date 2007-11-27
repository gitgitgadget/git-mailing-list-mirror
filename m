From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH RFC] Move all dashed form git commands to libexecdir
Date: Tue, 27 Nov 2007 10:25:33 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711271024460.9605@xanadu.home>
References: <20071127150229.GA14859@laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_sCHnnLJxZkvZr0bo1OAcFg)"
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix2K6-0000Ri-NQ
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbXK0PZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756421AbXK0PZp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:25:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53528 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbXK0PZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:25:44 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS600CKT86LFL60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Nov 2007 10:25:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071127150229.GA14859@laptop>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66230>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_sCHnnLJxZkvZr0bo1OAcFg)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Tue, 27 Nov 2007, Nguyễn Thái Ngọc Duy wrote:

>  We have talked about it for quite some time now. How about
>  making it happen? I won't miss dashed form commands much :)
> 
>  A compromised approach could be keeping porcelain commands
>  in bindir, only plumbings are moved to libexecdir. That would
>  be less shock than this.

I think that would be an excellent idea.


Nicolas

--Boundary_(ID_sCHnnLJxZkvZr0bo1OAcFg)--
