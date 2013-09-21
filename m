From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/17] np/pack-v4 updates
Date: Sat, 21 Sep 2013 12:07:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309211205550.312@syhkavp.arg>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_JLcqlbpZNS99l1EFVgJD/A)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 18:08:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNPjE-0001ms-T7
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 18:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab3IUQIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 12:08:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39817 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab3IUQIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 12:08:12 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTH00MI4GTNHJ20@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 21 Sep 2013 12:08:11 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 881452DA03F1; Sat, 21 Sep 2013 12:08:11 -0400 (EDT)
In-reply-to: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235128>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_JLcqlbpZNS99l1EFVgJD/A)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 21 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> This contains many bug fixes or cleanups. Also you can now run the
> test suite with v4 by setting GIT_TEST_OPTS=--packv4. The test suite
> passes now. pack size limit is not officially not supported with v4.
> index-pack also learns to convert appended trees to v4 for completing
> thin packs (still need to convert commits though)
> 
> PS. Nico do you still take patches and then send pull requests to
> Junio occasionally, or should I start to CC Junio?

I'm still willing to act as the middle man if that suits everybody.  
That gives me the opportunity to review those patches and stay minimally 
involved.


Nicolas

--Boundary_(ID_JLcqlbpZNS99l1EFVgJD/A)--
