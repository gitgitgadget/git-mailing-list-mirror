From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Tue, 03 Sep 2013 02:00:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_te9bV7TKjq72LA8LJitInA)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 08:00:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGjf8-00058y-KT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 08:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab3ICGAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 02:00:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48620 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3ICGAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 02:00:22 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSJ00DFPCOKJ760@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Sep 2013 02:00:20 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 994842DA0547; Tue, 03 Sep 2013 02:00:20 -0400 (EDT)
In-reply-to: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233680>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_te9bV7TKjq72LA8LJitInA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 31 Aug 2013, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Incorporated suggestions by Nico and Junio. I went ahead and added
>  escape hatches for converting thin packs to full ones so the document
>  does not really match the code (I've been watching Nico's repository,
>  commit reading is added, good stuff!)

Now tree reading is added.  multiple encoding bug fixes trickled down to 
their originating commits as well.

Something is still wrong with deltas though.


Nicolas

--Boundary_(ID_te9bV7TKjq72LA8LJitInA)--
